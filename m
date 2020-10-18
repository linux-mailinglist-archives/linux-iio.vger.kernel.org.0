Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA25C291537
	for <lists+linux-iio@lfdr.de>; Sun, 18 Oct 2020 03:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440095AbgJRBOe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 17 Oct 2020 21:14:34 -0400
Received: from mout.gmx.net ([212.227.15.18]:46069 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440084AbgJRBOe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 17 Oct 2020 21:14:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602983624;
        bh=LJP+KriKdGjpMcY1CtvW6omWMCmOlJNTjPQaEG7uDPE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=YSkGdx+ie1qdxT/9uFS7Srwj+B0qXhAsV1tftl1kJfYMsAnKV5X6T6GbSQzDMDB0O
         2iU++AOA/ALKT451hJo3vESTni6nxkN4NcaFsr7ubrQDMRVvN6CzVCj3tzAcpM1h8q
         A6as1ZY+mJghHY4z5PaV0y5gq18x8ER5YtEKBotw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([78.42.220.31]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mz9Un-1kFqKh1c5D-00wDl2; Sun, 18
 Oct 2020 03:13:44 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     andy.shevchenko@gmail.com
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
Subject: [PATCH 2/2] iio:core: In iio_map_array_register() cleanup in case of error.
Date:   Sun, 18 Oct 2020 03:11:56 +0200
Message-Id: <1602983516-22913-3-git-send-email-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1602983516-22913-1-git-send-email-LinoSanfilippo@gmx.de>
References: <CAHp75VfQ=fFn_r43VPV0uPCkozS2K=VQsuSEyj0mF+7QVsFQuA@mail.gmail.com>
 <1602983516-22913-1-git-send-email-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/G0i5tr9fAo76BkwxEOgAf5BtvgmaSTud7gTCL5d5JZvpeNnkQj
 5fYQS7JXj4Inygb2B60ThlJq4ER43D3Ky9bfkPQNu54S0H5EsnLgoekzdwtfVl/9XfJvf4B
 W2f0sRKsj1TSSbN28MHoKIv8jJ8ncL+xUbSbS41sErvj2PXIBAXzV5KMaCm13tju25/hfxc
 bm4TQ6lzYZ1Z8GC2aW97w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DboLyUSQS+Q=:LnWLtiC+oQ5Nwl0WPbpwqU
 WNLy1ztDvFoTdpXl+PPBvzx+B8OsFN4odB1aXf9h38XSI+ddsnAiw2TVnfN/Ft1NriskZ3gNm
 zRpLrm4ds9uSCrgeN0PihpXZ2TR3bd+vXIHhU86wJ5m19sFZHVK+deOO6NG/eVQfiqnW8EeHZ
 F4nTtsBwE+gPfUbHIOtJ0eDIACUYo6gH6MK5bYw4rDYu63EvhkwhYHtg62iY9kEZIr0TkZkXD
 UVU6zuuiyoLFtV57xUKnlkbv4JniALpZDomXD4DqkF+mR1uovTB0dOfqM3H7/HPM35DWIMRpv
 I7lpm3rC5jTh5A+lph/1Q7+uVH9FOPjZPLdsno6Z1kd8kKJcFmGSEvZgh9CnLzQRMwHWOmApo
 Klmuzpq5dUfH9IjnuZ05UOwWh2O/7kB/mNMKviivhkBrEC0GU3BXcozPIwGJ5x/CYzPOT9AYQ
 DI91ei30k8y87CTMcleWnYivtn+kl1karu6GSsZvFXnyyXUEQ1v1c0d2ivMpmMosQO0/EYgWM
 NRdazR9ygCTFsRc6MgVl4GyfclY76BmcSXhdheidepN5oWf/pfeSE8X2vgrPfywZVC6T7SCQr
 fYzd9VViSIjwPIrHNlQ/3TjfBfR4MJFhQmPTCeTe443e4/9KLILFh0uCKdjdLAyJHXulZ8KfV
 QYg9jwfuTgkwu1Ws8lhDo/Zy26q14HcJTUlj1VmDfc/O0N20wULYwJgifoFR/kVcqHDZsCJli
 JVVWut2/DxtbnlyE0EhRQiDdl1vZyhduCXNJEXi7Zb+RRdIS3HVtqpd0Ko+U2EPvj+X1OF198
 /2+Um96FTLdBPy7kyx3EbzjVJ5z67tz3haGMAGOddTokVkMMac6X3lmndNdb9sObm+CPHVnoB
 ee0LZVA8ooB4/IlY0MuQ==
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In function iio_map_array_register() properly rewind in case of error.

Signed-off-by: Lino Sanfilippo <LinoSanfilippo@gmx.de>
---
 drivers/iio/inkern.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 39c1d63..fe30bcb 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -60,6 +60,8 @@ int iio_map_array_register(struct iio_dev *indio_dev, str=
uct iio_map *maps)
 		i++;
 	}
 error_ret:
+	if (ret)
+		iio_map_array_unregister_locked(indio_dev);
 	mutex_unlock(&iio_map_list_lock);
=20
 	return ret;
--=20
2.7.4

