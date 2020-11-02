Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D792A2AFC
	for <lists+linux-iio@lfdr.de>; Mon,  2 Nov 2020 13:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbgKBMuM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 2 Nov 2020 07:50:12 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40806 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728599AbgKBMuM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Nov 2020 07:50:12 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A2CnxDA056196;
        Mon, 2 Nov 2020 06:49:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604321399;
        bh=ubYN/MufBybuGzbX2j0LPXwsO/e+Ls1IrcOs20wLmL0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=JiOdFOq4wJMm9cwCqXaPMb8akGIKgwdEBEG/xYrVZ4M8SbUaE7pcdkLSr5R6kH5YN
         TNW/XjM9VyC+kwnRQqs1MnSd6/l00yOrah4GLcrHE/rtCPHntWx1X9ngDCr1BDBkWy
         wWqgHTwtxnbluv8+Kcbh035zmKtigsaI/6NShk5o=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A2CnxBG037379
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Nov 2020 06:49:59 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 2 Nov
 2020 06:49:59 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 2 Nov 2020 06:49:59 -0600
Received: from [10.250.36.55] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A2Cnx1m060281;
        Mon, 2 Nov 2020 06:49:59 -0600
Subject: Re: [PATCH 37/46] dt-binding:iio:adc:ti,ads124s08: txt to yaml format
 conversion.
To:     Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20201031184854.745828-1-jic23@kernel.org>
 <20201031184854.745828-38-jic23@kernel.org>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <db16627a-d405-1b8f-bec9-da41f7faabf8@ti.com>
Date:   Mon, 2 Nov 2020 06:49:54 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201031184854.745828-38-jic23@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Jonathan

On 10/31/20 1:48 PM, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Simple binding so straight forward format conversion.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Dan Murphy <dmurphy@ti.com>
> ---
>   .../bindings/iio/adc/ti,ads124s08.yaml        | 52 +++++++++++++++++++
>   .../bindings/iio/adc/ti-ads124s08.txt         | 25 ---------
>   2 files changed, 52 insertions(+), 25 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads124s08.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads124s08.yaml
> new file mode 100644
> index 000000000000..5912a52953fa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads124s08.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
GPL-2.0-only  OR BSD-2-Clause

Otherwise

Reviewed-by: Dan Murphy <dmurphy@ti.com>

