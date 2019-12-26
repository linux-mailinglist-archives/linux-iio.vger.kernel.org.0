Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6520E12AF80
	for <lists+linux-iio@lfdr.de>; Fri, 27 Dec 2019 00:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfLZXED (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 26 Dec 2019 18:04:03 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:35818 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfLZXEC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Dec 2019 18:04:02 -0500
Received: by mail-io1-f66.google.com with SMTP id v18so24407708iol.2;
        Thu, 26 Dec 2019 15:04:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4BxjXm5H+PVHzK3XnFpnxXvTcIKYGmKgODVv5UHOsHg=;
        b=jhYa0XdG6jucyom2rEO5XNwOZjvxQXfQIVg7lVhBedfFrIK04Scj57ByNyFuIoNS1W
         Kos61ivoZF8rjCTTR4XhTCsPfuY7VhWyTHp2a4bTnnEOPAuGHk7rRokMI9jRAstwoyNV
         +N4hOf8oWL4CinJ0vwYsbNCnZk6Jgvmbq/hBN06ZEZRhPb+hvUUbfXKMX0z/+k6T2Fo1
         TXcPIY3HL2BeUb8Si0qQdiXNp5TrO3tNjH0/3khss/cZVftlkygi557/dMHTYgGB4UQs
         v5EW7usF3jgh+QzE74JZg4nzvc4o+YvuT+4CaRtmfBOHnTWbE72p76zKALFlu6Qj/AmX
         kKIw==
X-Gm-Message-State: APjAAAWdcy7UtBL5o0mv4WznWQyp83h6oAhE0YC9cHkrcIOVpRfgn4yo
        nLG1KYr0FlDN8L3G/zKHLg==
X-Google-Smtp-Source: APXvYqw2bGRiaMi/uFha0sHVD0awLqueKW90FLWiT0CRk7JBZTxizfad7ua9GqHYh9EH1UVXI14/eg==
X-Received: by 2002:a5d:93cd:: with SMTP id j13mr31630721ioo.126.1577401442032;
        Thu, 26 Dec 2019 15:04:02 -0800 (PST)
Received: from localhost ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id p12sm11217395ils.11.2019.12.26.15.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 15:04:00 -0800 (PST)
Date:   Thu, 26 Dec 2019 16:03:59 -0700
From:   Rob Herring <robh@kernel.org>
To:     Dan Robertson <dan@dlrobertson.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        devicetree@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Joe Perches <joe@perches.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v8 1/3] dt-bindings: iio: accel: bma400: add bindings
Message-ID: <20191226230359.GA29435@bogus>
References: <20191220160051.26321-1-dan@dlrobertson.com>
 <20191220160051.26321-2-dan@dlrobertson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191220160051.26321-2-dan@dlrobertson.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Dec 20, 2019 at 04:00:49PM +0000, Dan Robertson wrote:
> Add devicetree binding for the Bosch BMA400 3-axes ultra-low power
> accelerometer sensor.
> 
> Signed-off-by: Dan Robertson <dan@dlrobertson.com>
> ---
>  .../bindings/iio/accel/bosch,bma400.yaml      | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/bosch,bma400.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bma400.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bma400.yaml
> new file mode 100644
> index 000000000000..e87cb636b3e2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/accel/bosch,bma400.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/accel/bosch,bma400.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Bosch BMA400 triaxial acceleration sensor
> +
> +maintainers:
> +  - Dan Robertson <dan@dlrobertson.com>
> +
> +description: |
> +  Acceleration and temerature iio sensors with an i2c interface

checkpatch reports a typo here.

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>
