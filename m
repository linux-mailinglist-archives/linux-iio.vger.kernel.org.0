Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36F011733BA
	for <lists+linux-iio@lfdr.de>; Fri, 28 Feb 2020 10:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgB1JVh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 28 Feb 2020 04:21:37 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:48093 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgB1JVg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 28 Feb 2020 04:21:36 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200228092135euoutp01d18c9547c09e39a70a7955b567f41970~3hoPofXVh1971019710euoutp016
        for <linux-iio@vger.kernel.org>; Fri, 28 Feb 2020 09:21:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200228092135euoutp01d18c9547c09e39a70a7955b567f41970~3hoPofXVh1971019710euoutp016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1582881695;
        bh=60orSmm5KONwPF6rHsBABW9a8520HrdG+O9aycnqB5s=;
        h=From:To:Cc:Subject:Date:References:From;
        b=ZFPCtbcrjA6X9ArHtGauTUzEi70ZH3WbTdl/5e7zL7Mtk7fzmZ9uTu+J2t+h9RFmf
         voIslAzG8Wdm/GWi06P47Q4TYKcElpoLNFg1Y7mvxu/Z3vvW/0ZJYMk6rRErXH9kQj
         wGzQV+gfDnKjYI54qERhREQvODVEEV1d/17/a2KA=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200228092134eucas1p2b17bcab55009862992d565ed4536cc20~3hoPYTgAV0231702317eucas1p2q;
        Fri, 28 Feb 2020 09:21:34 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 23.1F.60679.E9BD85E5; Fri, 28
        Feb 2020 09:21:34 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200228092134eucas1p226ebb0e76f2a6c82b62489ae3a0379bd~3hoPBUBxk0231802318eucas1p2c;
        Fri, 28 Feb 2020 09:21:34 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200228092134eusmtrp105fcc6beb887dff0efdb7cdddf8cb7a8~3hoPAoa641945619456eusmtrp1X;
        Fri, 28 Feb 2020 09:21:34 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-c4-5e58db9eceb6
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id CB.FC.07950.E9BD85E5; Fri, 28
        Feb 2020 09:21:34 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200228092134eusmtip26a4bb18a6d25dac07d3b49f95f195e58~3hoOlop1M1481114811eusmtip2D;
        Fri, 28 Feb 2020 09:21:33 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-iio@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] iio: adc: exynos: Silence warning about regulators during
 deferred probe
Date:   Fri, 28 Feb 2020 10:21:21 +0100
Message-Id: <20200228092121.15918-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFIsWRmVeSWpSXmKPExsWy7djPc7rzbkfEGSycqmXxoGkVk8Wu/2+Y
        Lc6f38BusWTyfFaLeUfesVjMOL+PyWLtkbvsFr93HWN34PD48DHOY9OqTjaPJW8OsXqcbz7C
        6NG3ZRWjx+dNcgFsUVw2Kak5mWWpRfp2CVwZR1bNZiqYzl6x4/sMpgbGv6xdjJwcEgImEj/2
        P2fsYuTiEBJYwSgx8+oNKOcLo8Sb6dtYIZzPjBInlrTAtaxofwxVtZxR4vvTP6xwLV/2P2QH
        qWITMJToetvFBmKLCDhITJ5zihmkiFngK6PEkgcbmEASwgLREqvnPAIrYhFQlfj49AaYzStg
        K/F8+2qodfISqzccAGuWELjPJnHw901GiISLxPHnl9kgbGGJV8e3sEPYMhKnJ/ewQDQ0M0o8
        PLeWHcLpYZS43DQDqtta4s65X0DdHEA3aUqs36UPEXaU2Nr4hh0kLCHAJ3HjrSBImBnInLRt
        OjNEmFeio00IolpNYtbxdXBrD164xAxhe0hcfXKTBcQWEoiVeHrrJcsERrlZCLsWMDKuYhRP
        LS3OTU8tNspLLdcrTswtLs1L10vOz93ECEwRp/8d/7KDcdefpEOMAhyMSjy8C3aExwmxJpYV
        V+YeYpTgYFYS4d34NTROiDclsbIqtSg/vqg0J7X4EKM0B4uSOK/xopexQgLpiSWp2ampBalF
        MFkmDk6pBsZtlb4sbq+nPizfzX006s6mad57onY4csXYrw7zYTLeXGvzyvy5nqVm6g0Hl2hB
        O9/KKwl/mLb/+Clu/6NYiX3T6bi13WzdAoJzZ/+RNgt/ESBw+vvVtHlyS0UinfhqCniKhae9
        cBFlTzieuvq2SXs205XNhr7OnDHRlxr7U77/Te1xXciwXYmlOCPRUIu5qDgRAEkvfrENAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHLMWRmVeSWpSXmKPExsVy+t/xe7rzbkfEGZy/K2XxoGkVk8Wu/2+Y
        Lc6f38BusWTyfFaLeUfesVjMOL+PyWLtkbvsFr93HWN34PD48DHOY9OqTjaPJW8OsXqcbz7C
        6NG3ZRWjx+dNcgFsUXo2RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5
        mWWpRfp2CXoZR1bNZiqYzl6x4/sMpgbGv6xdjJwcEgImEivaHzN2MXJxCAksZZT4OPEMI0RC
        RuLktAaoImGJP9e62CCKPjFKXNp2hQkkwSZgKNH1FiTBySEi4CRxZNEFMJtZ4CejxIy+ehBb
        WCBS4kXrIrChLAKqEh+f3gCr4RWwlXi+fTXUAnmJ1RsOME9g5FnAyLCKUSS1tDg3PbfYSK84
        Mbe4NC9dLzk/dxMjMCy3Hfu5ZQdj17vgQ4wCHIxKPLwe28LjhFgTy4orcw8xSnAwK4nwbvwa
        GifEm5JYWZValB9fVJqTWnyI0RRo+URmKdHkfGDM5JXEG5oamltYGpobmxubWSiJ83YIHIwR
        EkhPLEnNTk0tSC2C6WPi4JRqYNymvPmazmvGOf1qynJzFJavtFiV0Li7dOGzQtcixyUXA5mm
        vFsZuZDje2ecsnq30gGTG49Ot7xoueLQnFApWewfkq6bvf/xouV2mzY/NH7Q8pNXnncnd0nL
        khmVL7o7DvvlJMppb7tqo54p0rKxKiW1nYNRv3Gf0BVtCaVG76UB20557bippcRSnJFoqMVc
        VJwIAEdsqC9hAgAA
X-CMS-MailID: 20200228092134eucas1p226ebb0e76f2a6c82b62489ae3a0379bd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200228092134eucas1p226ebb0e76f2a6c82b62489ae3a0379bd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200228092134eucas1p226ebb0e76f2a6c82b62489ae3a0379bd
References: <CGME20200228092134eucas1p226ebb0e76f2a6c82b62489ae3a0379bd@eucas1p2.samsung.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Don't confuse user with meaningless warning about the failure in getting
regulators in case of deferred probe.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iio/adc/exynos_adc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index 2df7d057b249..22131a677445 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -836,8 +836,10 @@ static int exynos_adc_probe(struct platform_device *pdev)
 
 	info->vdd = devm_regulator_get(&pdev->dev, "vdd");
 	if (IS_ERR(info->vdd)) {
-		dev_err(&pdev->dev, "failed getting regulator, err = %ld\n",
-							PTR_ERR(info->vdd));
+		if (PTR_ERR(info->vdd) != -EPROBE_DEFER)
+			dev_err(&pdev->dev,
+				"failed getting regulator, err = %ld\n",
+				PTR_ERR(info->vdd));
 		return PTR_ERR(info->vdd);
 	}
 
-- 
2.17.1

