Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40D86CE30F
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2019 15:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbfJGNSD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Oct 2019 09:18:03 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:58533 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbfJGNSD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Oct 2019 09:18:03 -0400
X-Originating-IP: 86.207.98.53
Received: from localhost (aclermont-ferrand-651-1-259-53.w86-207.abo.wanadoo.fr [86.207.98.53])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id D4830E0003;
        Mon,  7 Oct 2019 13:17:58 +0000 (UTC)
Date:   Mon, 7 Oct 2019 15:17:56 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Sebastian Reichel <sre@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH 3/4] dt-bindings: rtc: s3c: Include generic dt-schema
 bindings
Message-ID: <20191007131756.GK4254@piout.net>
References: <20191002160744.11307-1-krzk@kernel.org>
 <20191002160744.11307-3-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002160744.11307-3-krzk@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 02/10/2019 18:07:43+0200, Krzysztof Kozlowski wrote:
> Include the generic rtc.yaml bindings in Samsung S3C RTC bindings.  This
> brings the requirement of proper node names and adds parsing of
> additional properties.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  Documentation/devicetree/bindings/rtc/s3c-rtc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/s3c-rtc.yaml b/Documentation/devicetree/bindings/rtc/s3c-rtc.yaml
> index 4d91cdc9b998..76bbf8b7555b 100644
> --- a/Documentation/devicetree/bindings/rtc/s3c-rtc.yaml
> +++ b/Documentation/devicetree/bindings/rtc/s3c-rtc.yaml
> @@ -48,6 +48,7 @@ properties:
>      maxItems: 2
>  
>  allOf:
> +  - $ref: rtc.yaml#
>    - if:
>        properties:
>          compatible:
> -- 
> 2.17.1
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
