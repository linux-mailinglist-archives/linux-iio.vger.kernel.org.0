Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0CA04FAB1
	for <lists+linux-iio@lfdr.de>; Sun, 23 Jun 2019 09:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726056AbfFWH4p (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 Jun 2019 03:56:45 -0400
Received: from mail10.wdc04.mandrillapp.com ([205.201.139.10]:59202 "EHLO
        mail10.wdc04.mandrillapp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726378AbfFWH4o (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Jun 2019 03:56:44 -0400
X-Greylist: delayed 904 seconds by postgrey-1.27 at vger.kernel.org; Sun, 23 Jun 2019 03:56:43 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=mandrill; d=nexedi.com;
 h=From:Subject:To:Cc:Message-Id:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding; i=kirr@nexedi.com;
 bh=SQoaU4CrfNl4Jf6eu/xkbrQQO2NHeGQLLOHbulVuvP0=;
 b=ZwaquKaAAIpxxVQEmVOT20IFfM3TMqO23bu/l9VI1hdlMD38vOfkJAPHN+oLM6CxHTN+K/l0/Yrt
   IGni4RFYHR+YACpcXAjgkPsVqzXAV2IfAZhtGtA8g04LwaFhcmIDpWnzLDeDrHLiuoSr+X2dMc3W
   22/snrvgn7MtTVocGo4=
Received: from pmta08.mandrill.prod.suw01.rsglab.com (127.0.0.1) by mail10.wdc04.mandrillapp.com id h1sobo1jvmgc for <linux-iio@vger.kernel.org>; Sun, 23 Jun 2019 07:29:04 +0000 (envelope-from <bounce-md_31050260.5d0f2a40.v1-58a979e9d737410fa520058dacd342e3@mandrillapp.com>)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandrillapp.com; 
 i=@mandrillapp.com; q=dns/txt; s=mandrill; t=1561274944; h=From : 
 Subject : To : Cc : Message-Id : In-Reply-To : References : Date : 
 MIME-Version : Content-Type : Content-Transfer-Encoding : From : 
 Subject : Date : X-Mandrill-User : List-Unsubscribe; 
 bh=SQoaU4CrfNl4Jf6eu/xkbrQQO2NHeGQLLOHbulVuvP0=; 
 b=heJrSMnHQWCGWzsl8h/w5zgwVtCwfoZnUV0KKdOcVCJFq23XOse0MannbQ15D+vKAXkJKb
 i40erQl26b5//TWMWUUKri8AORF/xUA8LgF0y4VItMSSdNpfNOf6EnrkRwvKexBm6P6giEc/
 693nMiLlsQzxwU9XyKJ0YA4VW6qoY=
From:   Kirill Smelkov <kirr@nexedi.com>
Subject: [PATCH 2/2] *: convert stream-like files -> stream_open, even if they use noop_llseek
Received: from [87.98.221.171] by mandrillapp.com id 58a979e9d737410fa520058dacd342e3; Sun, 23 Jun 2019 07:29:04 +0000
X-Mailer: git-send-email 2.20.1
To:     <cocci@systeme.lip6.fr>, <linux-input@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc:     Kirill Smelkov <kirr@nexedi.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Jan Blunck <jblunck@suse.de>, Arnd Bergmann <arnd@arndb.de>,
        Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Message-Id: <20190623072838.31234-2-kirr@nexedi.com>
In-Reply-To: <20190623072838.31234-1-kirr@nexedi.com>
References: <20190623072838.31234-1-kirr@nexedi.com>
X-Report-Abuse: Please forward a copy of this message, including all headers, to abuse@mandrill.com
X-Report-Abuse: You can also report abuse here: http://mandrillapp.com/contact/abuse?id=31050260.58a979e9d737410fa520058dacd342e3
X-Mandrill-User: md_31050260
Date:   Sun, 23 Jun 2019 07:29:04 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch continues 10dce8af3422 (fs: stream_open - opener for
stream-like files so that read and write can run simultaneously without
deadlock) and c5bf68fe0c86 (*: convert stream-like files from
nonseekable_open -> stream_open) and teaches steam_open.cocci to
consider files as being stream-like not only if they have
.llseek=no_llseek, but also if they have .llseek=noop_llseek.

This is safe to do: the comment about noop_llseek says

	This is an implementation of ->llseek useable for the rare special case when
	userspace expects the seek to succeed but the (device) file is actually not
	able to perform the seek. In this case you use noop_llseek() instead of
	falling back to the default implementation of ->llseek.

and in general noop_llseek was massively added to drivers in 6038f373a3dc
(llseek: automatically add .llseek fop) when changing default for NULL .llseek
from NOP to no_llseek with the idea to avoid breaking compatibility, if
maybe some user-space program was using lseek on a device without caring
about the result, but caring if it was an error or not.

Amended semantic patch produces two changes when applied tree-wide:

        drivers/hid/hid-sensor-custom.c:690:8-24: WARNING: hid_sensor_custom_fops: .read() has stream semantic; safe to change nonseekable_open -> stream_open.
        drivers/input/mousedev.c:564:1-17: ERROR: mousedev_fops: .read() can deadlock .write(); change nonseekable_open -> stream_open to fix.

Cc: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Jan Blunck <jblunck@suse.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Kirill Smelkov <kirr@nexedi.com>
---
 drivers/hid/hid-sensor-custom.c          | 2 +-
 drivers/input/mousedev.c                 | 2 +-
 scripts/coccinelle/api/stream_open.cocci | 9 ++++++++-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
index c60f82673cf2..fb827c295842 100644
--- a/drivers/hid/hid-sensor-custom.c
+++ b/drivers/hid/hid-sensor-custom.c
@@ -687,7 +687,7 @@ static int hid_sensor_custom_open(struct inode *inode, struct file *file)
 	if (test_and_set_bit(0, &sensor_inst->misc_opened))
 		return -EBUSY;
 
-	return nonseekable_open(inode, file);
+	return stream_open(inode, file);
 }
 
 static __poll_t hid_sensor_custom_poll(struct file *file,
diff --git a/drivers/input/mousedev.c b/drivers/input/mousedev.c
index 412fa71245af..58afd5253485 100644
--- a/drivers/input/mousedev.c
+++ b/drivers/input/mousedev.c
@@ -561,7 +561,7 @@ static int mousedev_open(struct inode *inode, struct file *file)
 		goto err_free_client;
 
 	file->private_data = client;
-	nonseekable_open(inode, file);
+	stream_open(inode, file);
 
 	return 0;
 
diff --git a/scripts/coccinelle/api/stream_open.cocci b/scripts/coccinelle/api/stream_open.cocci
index 12ce18fa6b74..df00d6619b06 100644
--- a/scripts/coccinelle/api/stream_open.cocci
+++ b/scripts/coccinelle/api/stream_open.cocci
@@ -134,6 +134,13 @@ identifier fops0.fops;
     .llseek = no_llseek,
   };
 
+@ has_noop_llseek @
+identifier fops0.fops;
+@@
+  struct file_operations fops = {
+    .llseek = noop_llseek,
+  };
+
 @ has_mmap @
 identifier fops0.fops;
 identifier mmap_f;
@@ -180,7 +187,7 @@ identifier splice_write_f;
 //
 // XXX for simplicity require no .{read/write}_iter and no .splice_{read/write} for now.
 // XXX maybe_steam.fops cannot be used in other rules - it gives "bad rule maybe_stream or bad variable fops".
-@ maybe_stream depends on (!has_llseek || has_no_llseek) && !has_mmap && !has_copy_file_range && !has_remap_file_range && !has_read_iter && !has_write_iter && !has_splice_read && !has_splice_write @
+@ maybe_stream depends on (!has_llseek || has_no_llseek || has_noop_llseek) && !has_mmap && !has_copy_file_range && !has_remap_file_range && !has_read_iter && !has_write_iter && !has_splice_read && !has_splice_write @
 identifier fops0.fops;
 @@
   struct file_operations fops = {
-- 
2.20.1
