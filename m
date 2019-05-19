Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 122DB227B9
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2019 19:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfESRas (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 19 May 2019 13:30:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34790 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbfESRas (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 May 2019 13:30:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=f5cN1mjIK4arJv5nxA+9gsIwVDLFcCDiUgKYVbUOMOo=; b=LX6LYvYYN+sOMe2wiacM1uzR3
        zyvtL3DggelCbv5RiTtNft2qx7wFDxH5pTpIbCDTaoJqYX5E91v4TP2kfm5xN50a6/egfLVwuPd9e
        c4S+CzzslEPNlKXjStrmXj/SvMJnh15TCDdcJAdw1TBKVbf2LJj7MMA6PUMmW8rKa7OTxYDc05RTl
        n3Vy4MmzUg38kQlJrky+fVTsL2NzPF097e/IML8fmGeuI09yKl057LEsCLXbWGn+6xoFLHawUwhiY
        1bM8EmSsPVOJkv2Lt4JXFNs1fmtgxVbbKfqIc43YlZXAukSjSkDqdsshbBlYtlKR3cYL8freek6Ne
        qPyvJa5eA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hSDSR-0006bj-41; Sun, 19 May 2019 04:29:59 +0000
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-iio@vger.kernel.org,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] counter: fix Documentation build error due to incorrect
 source file name
Message-ID: <b6475070-f336-1093-ff0f-6bc8d5fda35e@infradead.org>
Date:   Sat, 18 May 2019 21:29:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix kernel-doc build error in Documentation/driver-api/generic-counter.rst
of incorrect source file name.
Fixes this warning and error:

Error: Cannot open file ../drivers/counter/generic-counter.c
WARNING: kernel-doc '../scripts/kernel-doc -rst -enable-lineno -export ../drivers/counter/generic-counter.c' failed with return code 2

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: linux-iio@vger.kernel.org
---
 Documentation/driver-api/generic-counter.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20190517.orig/Documentation/driver-api/generic-counter.rst
+++ linux-next-20190517/Documentation/driver-api/generic-counter.rst
@@ -251,7 +251,7 @@ for defining a counter device.
 .. kernel-doc:: include/linux/counter.h
    :internal:
 
-.. kernel-doc:: drivers/counter/generic-counter.c
+.. kernel-doc:: drivers/counter/counter.c
    :export:
 
 Implementation


