Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCE7A252495
	for <lists+linux-iio@lfdr.de>; Wed, 26 Aug 2020 02:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgHZACr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 25 Aug 2020 20:02:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:59524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726483AbgHZACq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 25 Aug 2020 20:02:46 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C475F206EB;
        Wed, 26 Aug 2020 00:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598400166;
        bh=aBI3dtda/CdYpEmdbdOJXEkCTP84gg1IL93fqoIOK6U=;
        h=Date:From:To:Cc:Subject:From;
        b=D684WVqr2ndz7+Sjj5fwEDzm23k5ELhVAmaV8q49/bbroAZCVDvQWiYxLVfgKDIzm
         RP/IXHfd+nL2QKUJdt5BIM3di9KiEvbDqVo3uZ7VMV2ANGD0P03b7FdSyVpGViVnY9
         +WzxySHOy6qYI7fBdDP2j44mxv6Cre6QDTe2eZPs=
Date:   Tue, 25 Aug 2020 19:08:44 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH] iio: dpot-dac: fix code comment in dpot_dac_read_raw()
Message-ID: <20200826000844.GA16807@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

After the replacement of the /* fall through */ comment with the
fallthrough pseudo-keyword macro, the natural reading of a code
comment was broken.

Fix the natural reading of such a comment and make it intelligible.

Reported-by: Peter Rosin <peda@axentia.se>
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/iio/dac/dpot-dac.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/dpot-dac.c b/drivers/iio/dac/dpot-dac.c
index be61c3b01e8b..1a9609eda5c5 100644
--- a/drivers/iio/dac/dpot-dac.c
+++ b/drivers/iio/dac/dpot-dac.c
@@ -74,10 +74,11 @@ static int dpot_dac_read_raw(struct iio_dev *indio_dev,
 		case IIO_VAL_INT:
 			/*
 			 * Convert integer scale to fractional scale by
-			 * setting the denominator (val2) to one, and...
+			 * setting the denominator (val2) to one...
 			 */
 			*val2 = 1;
 			ret = IIO_VAL_FRACTIONAL;
+			/* ...and fall through. Say it again for GCC. */
 			fallthrough;
 		case IIO_VAL_FRACTIONAL:
 			*val *= regulator_get_voltage(dac->vref) / 1000;
-- 
2.27.0

