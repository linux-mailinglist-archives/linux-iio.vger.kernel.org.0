Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26ED8635DC3
	for <lists+linux-iio@lfdr.de>; Wed, 23 Nov 2022 13:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237798AbiKWMqo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 23 Nov 2022 07:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237808AbiKWMpu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Nov 2022 07:45:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDE3286F9;
        Wed, 23 Nov 2022 04:42:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DDADB61C55;
        Wed, 23 Nov 2022 12:42:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9335AC433B5;
        Wed, 23 Nov 2022 12:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669207367;
        bh=HQnziATy9GXeouqLcZTi0GRYACLnIQvqj6pEI65EoMw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=saS32qREy/Ra3DmyLdcbQxG1oa81pwa3rGqr/iHx//e2z72uQ/bE0vRAdhUD9WN/U
         sqqVmHerj34EjANgD96yxunvDygUXnEMpnnsBb94Tsq/XQMeynmzIdrxqxaJdZ5E/N
         oKq1XdcEN6tX2uCtmJfDcxjpb7rZ4n1mAE7Yra4b0ivIeTuy1Fw2C5vwsxrx51JMU/
         hHhdwtMlUB1DEQQ5puzIaksoiF1teKYxjXLdYAGtOMNu6Lq+80WtQoBTBKncw3/D0m
         XK+EYwS6PCgx3qoZu2jc/gSHMyhlqC6K2siwZuKbywBuJCMmoVTK7kPwmdSmgRdwJ1
         RYlP8enqlD3ig==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>, jic23@kernel.org,
        linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 05/31] tools: iio: iio_generic_buffer: Fix read size
Date:   Wed, 23 Nov 2022 07:42:06 -0500
Message-Id: <20221123124234.265396-5-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221123124234.265396-1-sashal@kernel.org>
References: <20221123124234.265396-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Matti Vaittinen <mazziesaccount@gmail.com>

[ Upstream commit 7c919b619bcc68158921b1bd968f0e704549bbb6 ]

When noevents is true and small buffer is used the allocated memory for
holding the data may be smaller than the hard-coded 64 bytes. This can
cause the iio_generic_buffer to crash.

Following was recorded on beagle bone black with v6.0 kernel and the
digit fix patch:
https://lore.kernel.org/all/Y0f+tKCz+ZAIoroQ@dc75zzyyyyyyyyyyyyycy-3.rev.dnainternet.fi/
using valgrind;

==339== Using Valgrind-3.18.1 and LibVEX; rerun with -h for copyright info
==339== Command: /iio_generic_buffer -n kx022-accel -T0 -e -l 10 -a -w 2000000
==339== Parent PID: 307
==339==
==339== Syscall param read(buf) points to unaddressable byte(s)
==339==    at 0x496BFA4: read (read.c:26)
==339==    by 0x11699: main (iio_generic_buffer.c:724)
==339==  Address 0x4ab3518 is 0 bytes after a block of size 160 alloc'd
==339==    at 0x4864B70: malloc (vg_replace_malloc.c:381)
==339==    by 0x115BB: main (iio_generic_buffer.c:677)

Fix this by always using the same size for reading as was used for
data storage allocation.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Link: https://lore.kernel.org/r/Y0kMh0t5qUXJw3nQ@dc75zzyyyyyyyyyyyyycy-3.rev.dnainternet.fi
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/iio/iio_generic_buffer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
index 2491c54a5e4f..f8deae4e26a1 100644
--- a/tools/iio/iio_generic_buffer.c
+++ b/tools/iio/iio_generic_buffer.c
@@ -715,12 +715,12 @@ int main(int argc, char **argv)
 				continue;
 			}
 
-			toread = buf_len;
 		} else {
 			usleep(timedelay);
-			toread = 64;
 		}
 
+		toread = buf_len;
+
 		read_size = read(buf_fd, data, toread * scan_size);
 		if (read_size < 0) {
 			if (errno == EAGAIN) {
-- 
2.35.1

