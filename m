Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D38A68E5AC
	for <lists+linux-iio@lfdr.de>; Thu, 15 Aug 2019 09:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729967AbfHOHnr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 15 Aug 2019 03:43:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34947 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfHOHnr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 15 Aug 2019 03:43:47 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hyAQ7-0001ax-LF; Thu, 15 Aug 2019 07:43:39 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Martyn Welch <martyn.welch@collabora.com>,
        Sergei M <fizik1@yandex.com>, linux-iio@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][iio-next] iio: light: noa1305: fix missing break in a switch statement
Date:   Thu, 15 Aug 2019 08:43:39 +0100
Message-Id: <20190815074339.32380-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a missing break for the NOA1305_INTEGR_TIME_400MS case,
fix it by adding it in.

Addresses-Coverity: ("Missing break in switch")
Fixes: 741172d18e8a ("iio: light: noa1305: Add support for NOA1305")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/iio/light/noa1305.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/light/noa1305.c b/drivers/iio/light/noa1305.c
index 7b859ae1044d..5ebfbc52f541 100644
--- a/drivers/iio/light/noa1305.c
+++ b/drivers/iio/light/noa1305.c
@@ -85,6 +85,7 @@ static int noa1305_scale(struct noa1305_priv *priv, int *val, int *val2)
 	case NOA1305_INTEGR_TIME_400MS:
 		*val = 100;
 		*val2 = 77 * 4;
+		break;
 	case NOA1305_INTEGR_TIME_200MS:
 		*val = 100;
 		*val2 = 77 * 2;
-- 
2.20.1

