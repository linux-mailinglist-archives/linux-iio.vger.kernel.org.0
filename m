Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 399DF302C2D
	for <lists+linux-iio@lfdr.de>; Mon, 25 Jan 2021 21:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731932AbhAYUE5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 25 Jan 2021 15:04:57 -0500
Received: from ns.pmeerw.net ([84.19.176.117]:47138 "EHLO ns.pmeerw.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731701AbhAYUEz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 25 Jan 2021 15:04:55 -0500
X-Greylist: delayed 403 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Jan 2021 15:04:54 EST
Received: by ns.pmeerw.net (Postfix, from userid 113)
        id 34387E0A25; Mon, 25 Jan 2021 20:56:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pmeerw.net; s=mail;
        t=1611604616; bh=vrJGhgp7jrRercITmEEH+f3rzAIl7vT3UrsVbjcIdH4=;
        h=From:To:Cc:Subject:Date:From;
        b=U9YwdgwV7BJdqKN2ksCLE4WN/sASjBzrd3slErL8cPsDL5rDVFotBZ+USdskqmNVp
         w+uiYjjoOfig4ZslsVNM70WsQ6Uzgc4CJVcuNYdMrVjzplOuFb6Q61gY8Itn7nwYFh
         L+92iTpg3CyG+PshjBHLWBcRc6I9LZUICkQnIeP4=
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on vps.pmeerw.net
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.5-pre1
Received: from localhost.localdomain (unknown [78.152.89.35])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmeerw@pmeerw.net)
        by ns.pmeerw.net (Postfix) with ESMTPSA id 1A0A1E0514;
        Mon, 25 Jan 2021 20:56:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pmeerw.net; s=mail;
        t=1611604615; bh=vrJGhgp7jrRercITmEEH+f3rzAIl7vT3UrsVbjcIdH4=;
        h=From:To:Cc:Subject:Date:From;
        b=c9qdOiuppbGlYQNPZSxCe/wRM2VgtN5lzJD5q0nVynWe5eV3q9zsyNGXb7gg1z58h
         ZjOVdGsyEQjau7YhullGA5yyiHeQA0nRSjnTJy5fMuJr0c8JhC6G0h8GaZxmpqdral
         bFTEcmohLM0jH0Cl761YwVII3bUocVreHBYPv6fA=
From:   Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: [PATCH] MAINTAINERS: iio: move Peter Meerwald-Stadler to CREDITS
Date:   Mon, 25 Jan 2021 20:56:54 +0100
Message-Id: <20210125195654.580465-1-pmeerw@pmeerw.net>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Haven't had much time lately and moved on to different things.
Thanks Jonathan for the gentle introduction to Linux land.

Signed-off-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
---
 CREDITS     | 8 ++++++++
 MAINTAINERS | 1 -
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/CREDITS b/CREDITS
index 090ed4b004a5..9b4f2fc469e4 100644
--- a/CREDITS
+++ b/CREDITS
@@ -2524,6 +2524,14 @@ D: Linux/PARISC hacker
 D: AD1889 sound driver
 S: Ottawa, Canada
 
+N: Peter Meerwald-Stadler
+E: pmeerw@pmeerw.net
+W: https://pmeerw.net
+D: IIO reviewing, drivers
+S: Schießstandstr. 3a
+S: A-5061 Elsbethen
+S: Austria
+
 N: Dirk Melchers
 E: dirk@merlin.nbg.sub.org
 D: 8 bit XT hard disk driver for OMTI5520
diff --git a/MAINTAINERS b/MAINTAINERS
index 546aa66428c9..c29bd9b90ac2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8664,7 +8664,6 @@ F:	drivers/iio/multiplexer/iio-mux.c
 IIO SUBSYSTEM AND DRIVERS
 M:	Jonathan Cameron <jic23@kernel.org>
 R:	Lars-Peter Clausen <lars@metafoo.de>
-R:	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
-- 
2.30.0

