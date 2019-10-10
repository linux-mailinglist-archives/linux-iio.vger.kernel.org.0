Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11718D32F4
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2019 22:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfJJUxc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Oct 2019 16:53:32 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37091 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbfJJUxc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Oct 2019 16:53:32 -0400
Received: by mail-ot1-f66.google.com with SMTP id k32so6129189otc.4;
        Thu, 10 Oct 2019 13:53:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e/t0HF/wqJSfNrnwPhBS9XOByD4MLCYu+o03s9uJ830=;
        b=GFwDQAPTrh/GqeLSUNm8F8lmG/fju0FWQPkCkSh5BL+yThASJMolLaAmYB82YHDsB3
         pBrwV1mM3VzVlW/5MEDDWDai5CNFCIzvxdMfPdtfdq5wGWcvqz4t5HJq9TvMnci44Udj
         Pmgke18S1fv7qjznHTzNZWv7EheklQzxh2bdzo0FM68Qm1ZRf4kJZHOUOMvGmh7Mm7sX
         7eH0ETYfoDb7mNHnX45QOH8/aPoMNh/K/P//8OZaTauL3umBPOW3iEX3iumzCwVy46HC
         BEpC9oxzTvyj72CaHZYsc0qRY8RSnYBdngPfCfJ+5oFU1NkF8f1q2gkfncZ3xOyd2ZaK
         x3BA==
X-Gm-Message-State: APjAAAVa+O+nq86qNc16OkSrGF5pCY06IlDs06eaMMnwnBqVGIPXqT4L
        TZz/+ydkuERRdeF17deZww==
X-Google-Smtp-Source: APXvYqws/sj2QT0mQsX1yIjAarwMmwwPfrIx/IFWvphM/0AsdleqskzJS1FEccZSdmd6jvq0Sm7mbw==
X-Received: by 2002:a9d:6e1a:: with SMTP id e26mr9651172otr.307.1570740809810;
        Thu, 10 Oct 2019 13:53:29 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k204sm2029360oif.33.2019.10.10.13.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 13:53:29 -0700 (PDT)
Date:   Thu, 10 Oct 2019 15:53:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     robh+dt@kernel.org, jic23@kernel.org, mark.rutland@arm.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: iio: maxbotix,mb1232.yaml: transform to
 yaml
Message-ID: <20191010205328.GA19956@bogus>
References: <20191007170219.xfipsry5nk4raiem@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007170219.xfipsry5nk4raiem@arbad>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 7 Oct 2019 19:02:20 +0200, Andreas Klinger wrote:
> transform existing documentation of maxbotix,mb1232 ultrasonic ranger
> from text documentation format into yaml.
> 
> Changes in v3:
> - add a i2c node around device node to set up #address-cells and
>   #size-cells for omitting error during make dt_binding_check
> 
> Changes in v2:
> - removed description of reg property
> - added a line:
>   additionalProperties: false
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> ---
>  .../bindings/iio/proximity/maxbotix,mb1232.txt     | 29 -----------
>  .../bindings/iio/proximity/maxbotix,mb1232.yaml    | 60 ++++++++++++++++++++++
>  2 files changed, 60 insertions(+), 29 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/proximity/maxbotix,mb1232.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/maxbotix,mb1232.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
