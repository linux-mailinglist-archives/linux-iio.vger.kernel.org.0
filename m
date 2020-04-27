Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8DA1BB080
	for <lists+linux-iio@lfdr.de>; Mon, 27 Apr 2020 23:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbgD0V23 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Apr 2020 17:28:29 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33026 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgD0V23 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Apr 2020 17:28:29 -0400
Received: by mail-ot1-f68.google.com with SMTP id j26so28953362ots.0;
        Mon, 27 Apr 2020 14:28:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=phD6dC2Al/yY/sFl+4yOknV0vS+D1yw4j8TAayBjiFg=;
        b=iukvoNJ2cPgAKzNmwckbw1VCQRnySWWsYHhnCcqtJDMI9AOULxeE7FJSUiDlMrkTSf
         uPFHkWS47KxNGdFCnEQf8iAlzlS1WzXE5R/YgeCuPRh8uiA1m8fosA9WLHCzkOJ4ZN1X
         nNtCQWYFga04Bk1uq7db/Ts7Ckc4eMhU5s6OQwK3Sqr2djr7OuL2dRxsHKPGyxBYJfNZ
         Zv6Z8zXldj+RJKc5uX1LxZlZ64+GX6ASe4hVkc7SSKgmxA/+P9ySBruJIYLA1RZtpqMp
         tRit7NXRZUIKFgaDO5M7ZWL2Z9Za9JGHkVc8+Icmb0/vsKr4I4HnwPSrKugJYjuC4Ocu
         qqPw==
X-Gm-Message-State: AGi0Pua98pTD3JOujhGuPiiWUjS5wZ8uiuoGwPiDK0GMekd6DsbgkTEf
        h+QT3VcEmUucC8jA5Qku3Qa8VrE=
X-Google-Smtp-Source: APiQypJpmhS3vEKwGO9a8rjv0tcUcZmOuxpwt+49p18dJ+soi/+5A308a/uPpAMwYkKk2MszA4Qv+g==
X-Received: by 2002:a54:4483:: with SMTP id v3mr637135oiv.0.1588022908294;
        Mon, 27 Apr 2020 14:28:28 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q142sm4345841oic.44.2020.04.27.14.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 14:28:27 -0700 (PDT)
Received: (nullmailer pid 26250 invoked by uid 1000);
        Mon, 27 Apr 2020 21:28:26 -0000
Date:   Mon, 27 Apr 2020 16:28:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     Tomasz Duszynski <tomasz.duszynski@octakon.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org, jic23@kernel.org,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>
Subject: Re: [PATCH 5/6] dt-bindings: iio: scd30: add device binding file
Message-ID: <20200427212826.GA25672@bogus>
References: <20200422141135.86419-1-tomasz.duszynski@octakon.com>
 <20200422141135.86419-6-tomasz.duszynski@octakon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422141135.86419-6-tomasz.duszynski@octakon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 22 Apr 2020 16:11:34 +0200, Tomasz Duszynski wrote:
> Add SCD30 sensor binding file.
> 
> Signed-off-by: Tomasz Duszynski <tomasz.duszynski@octakon.com>
> ---
>  .../iio/chemical/sensirion,scd30.yaml         | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,scd30.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/chemical/sensirion,scd30.example.dt.yaml: scd30@61: 'interrupt-parrent' does not match any of the regexes: 'pinctrl-[0-9]+'
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/chemical/sensirion,scd30.example.dt.yaml: scd30: 'interrupt-parrent' does not match any of the regexes: 'pinctrl-[0-9]+'

See https://patchwork.ozlabs.org/patch/1275131

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.
