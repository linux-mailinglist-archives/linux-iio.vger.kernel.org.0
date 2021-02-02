Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF80D30CD76
	for <lists+linux-iio@lfdr.de>; Tue,  2 Feb 2021 21:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbhBBU4w (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 2 Feb 2021 15:56:52 -0500
Received: from www381.your-server.de ([78.46.137.84]:42700 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbhBBU4p (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 2 Feb 2021 15:56:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=PqrDYmSRZ2jD1Y+JGfHbNOAlNj1MP00eiAyBOLDtoQU=; b=fmMatPxJz5ZgY20zUyd/ODST3z
        nC7pWu0OK0vfR7PngMA6phQvDPOky4PyV+YvHsSV6JAzDoP5fo4zM8JyQueOw3b668/HlB0kTTAHc
        j+hQIoTGkymnbT3rFeOZ4pQ5weC31SPMe1Hh6RW4zIDDCHsSuNxkJyBgjW3Pm3dyyUVFG+xIvS0zC
        gNDxcLGMreVXYLFDu0TUTGn4wWu/CnLmB6hb0rYrHrbr4P5KClJRrcwC4WpHAp2FOpA5mQ9UrL7ID
        Lpz5J4mAV3Q0u6dvYlbJ6BAJq3GELpoOSE1L7Y4C05vMY5Qxh9c0Z3fviDQ1127oqLhXSvXidtbrC
        rmPjp1RQ==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1l72iL-0008rA-50; Tue, 02 Feb 2021 21:55:57 +0100
Received: from [62.216.202.92] (helo=[192.168.178.20])
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1l72iK-000SPT-Vd; Tue, 02 Feb 2021 21:55:56 +0100
Subject: Re: [PATCH] dt-bindings: iio: dac: Add missing ad5686 compatible
 strings
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michael Auchter <michael.auchter@ni.com>,
        linux-iio@vger.kernel.org
References: <20210202181427.3934218-1-robh@kernel.org>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <efbfbb94-bf61-5503-9833-df23709f56a2@metafoo.de>
Date:   Tue, 2 Feb 2021 21:55:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210202181427.3934218-1-robh@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26068/Tue Feb  2 13:21:02 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2/2/21 7:14 PM, Rob Herring wrote:
> The example uses 'adi,ad5686', but the schema fails to document it. Given
> the filename and there is a similar part AD5686, let's just add the
> compatible strings including the 'r' variant.

There are two variants of this chip. One with a SPI interface and one 
with a I2C interface. This binding document only describes the I2C 
variants. But the ad5686 is a SPI variant.

I think this is a typo and we should replace ad5686 with ad5696, 
including the document name.

>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: Michael Auchter <michael.auchter@ni.com>
> Cc: linux-iio@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>   Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
> index 8065228e5df8..190919291828 100644
> --- a/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
> @@ -19,6 +19,8 @@ properties:
>         - adi,ad5338r
>         - adi,ad5671r
>         - adi,ad5675r
> +      - adi,ad5686
> +      - adi,ad5686r
>         - adi,ad5691r
>         - adi,ad5692r
>         - adi,ad5693


