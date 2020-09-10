Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3946E264DFA
	for <lists+linux-iio@lfdr.de>; Thu, 10 Sep 2020 20:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgIJS5i (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Sep 2020 14:57:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:33464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726512AbgIJS4k (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Sep 2020 14:56:40 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F17C21582;
        Thu, 10 Sep 2020 18:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599764189;
        bh=A8g/aGqwyv0RsVaiMq65Dp1PysUSdq1Ymqxl8zg45RM=;
        h=From:To:Cc:Subject:Date:From;
        b=s5xyR5etRdZ7KiKwIeNIAf/lJ4skF+79ZniqOiT1ZJfI2uDMNOCvFJevNZa20sX9p
         NfEoSoGLRCHeWNSIaZLb6ToXSmvCilttu1+PeK7oVMQgi44YSBErr8XZFutEFsIkhD
         0bJMQtD7gGk2h9hAvRw/Zo70eRl2zUXiLynbGEpE=
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH] kernel-doc: add support for ____cacheline_aligned attribute
Date:   Thu, 10 Sep 2020 19:54:15 +0100
Message-Id: <20200910185415.653139-1-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Subroutine dump_struct uses type attributes to check if the struct
syntax is valid. Then, it removes all attributes before using it for
output. `____cacheline_aligned` is an attribute that is
not included in both steps. Add it, since it is used by kernel structs.

Based on previous patch to add ____cacheline_aligned_in_smp.
Motivated by patches to reorder this attribute to before the
variable name.   Whilst we could do that in all cases, that would
be a massive change and it is more common in the kernel to place
this particular attribute after the variable name. A quick grep
suggests approximately 400 instances of which 341 have this
attribute just before a semicolon and hence after the variable name.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Lee Jones <lee.jones@linaro.org>
---

Note I haven't figured out what this is actually doing and hence the
patch is done by copying the changes made for ____cacheline_aligned_in_smp.
It seems to work. :)

 scripts/kernel-doc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index d1b445665ad6..cc55e1c2a8a4 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1083,7 +1083,7 @@ sub dump_struct($$) {
     my $x = shift;
     my $file = shift;
 
-    if ($x =~ /(struct|union)\s+(\w+)\s*\{(.*)\}(\s*(__packed|__aligned|____cacheline_aligned_in_smp|__attribute__\s*\(\([a-z0-9,_\s\(\)]*\)\)))*/) {
+    if ($x =~ /(struct|union)\s+(\w+)\s*\{(.*)\}(\s*(__packed|__aligned|____cacheline_aligned_in_smp|____cacheline_aligned|__attribute__\s*\(\([a-z0-9,_\s\(\)]*\)\)))*/) {
 	my $decl_type = $1;
 	$declaration_name = $2;
 	my $members = $3;
@@ -1099,6 +1099,7 @@ sub dump_struct($$) {
 	$members =~ s/\s*__packed\s*/ /gos;
 	$members =~ s/\s*CRYPTO_MINALIGN_ATTR/ /gos;
 	$members =~ s/\s*____cacheline_aligned_in_smp/ /gos;
+	$members =~ s/\s*____cacheline_aligned/ /gos;
 
 	# replace DECLARE_BITMAP
 	$members =~ s/__ETHTOOL_DECLARE_LINK_MODE_MASK\s*\(([^\)]+)\)/DECLARE_BITMAP($1, __ETHTOOL_LINK_MODE_MASK_NBITS)/gos;
-- 
2.28.0

