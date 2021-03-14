Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0270E33A771
	for <lists+linux-iio@lfdr.de>; Sun, 14 Mar 2021 19:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233985AbhCNSST (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Mar 2021 14:18:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:45238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233995AbhCNSR5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Mar 2021 14:17:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6106164EE3;
        Sun, 14 Mar 2021 18:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615745876;
        bh=w1XgIupIXsB9J+6Tum2u2vW2nJwexDTG3dvAq+yJGF4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HXouJmGSGVWm1mpxokLeLZlYNepMh18msZVOgLf/RvYOxOWsnt8Pz4TF6uZmiVybC
         JruQZ4Noj5+MZL9GgRDieS5s40i98urbFTmsBeapnv8JXcefuj78SI6OC7AKlK60QD
         ODnIZZVYduZPAAWXDtZurYJs4ROyJEaS8ngWd73Gq9GQuFjdHkpH6ih2e0d70SS6+P
         wbvr1vdMMzKL/wTAOhWqgVOGNtaD4Pc61HYAv1t3zNhdCnprMaSOBo2O1jNV31GrXH
         v4Cf0it3qb838EO7HHTGrvuCExiYi/SIgQD96TdYhtb7ROcAZKytu6rH5NdjkQL0gn
         UIG3gqnuydT1g==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Ardelean <aardelean@deviqon.com>, Robh+dt@kernel.org,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 17/24] staging:iio:cdc:ad7150: Shift the _raw readings by 4 bits.
Date:   Sun, 14 Mar 2021 18:15:04 +0000
Message-Id: <20210314181511.531414-18-jic23@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210314181511.531414-1-jic23@kernel.org>
References: <20210314181511.531414-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Every other register related to raw value on the datasheet is
described as correpsonding to the 12MSB of the actual
data registers + the bottom 4 bits are 0.  So lets treat this
as what it actually is, which is a 12 bit value.
Note that we will have to be a little careful to compensate for
the offset and scale values.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Link: https://lore.kernel.org/r/20210207154623.433442-18-jic23@kernel.org
---
 drivers/staging/iio/cdc/ad7150.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index 67af39f80650..1a041396ff9e 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -111,7 +111,7 @@ static int ad7150_read_raw(struct iio_dev *indio_dev,
 						  ad7150_addresses[channel][0]);
 		if (ret < 0)
 			return ret;
-		*val = ret;
+		*val = ret >> 4;
 
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_AVERAGE_RAW:
-- 
2.30.2

