Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 928F8139CEE
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2020 23:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbgAMWwk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 13 Jan 2020 17:52:40 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41607 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728986AbgAMWwk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Jan 2020 17:52:40 -0500
Received: by mail-oi1-f195.google.com with SMTP id i1so9966091oie.8
        for <linux-iio@vger.kernel.org>; Mon, 13 Jan 2020 14:52:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=J+zBhW/gDhabcv8JezsZDbLiOV+72tFZs2kFt+zjTFs=;
        b=WlpsEKmmQKgoBYksTJJQ9uoViSWWE+GVblpGlstUSnEHMtCTlfdydo3rJKhek/2z4M
         pWWRjnmQOWLY1XeXkHdwWGoRPlK3ROHKvo5dCshCdWQQsu3PqMnp4vGJdVJgJ07sgExF
         5BPTjBdUx3QhrWnraTLeNWN9f3/HHlWVJZHC7KE9dfP2nhErt5N6GLf4ZyqAzdF89LoN
         wbwTc2+IpJnuERT1j4gJINPog7eI8Sc7O33dLfJUuvEAOVjqlx+vxFkORV/YLUqjO/+d
         OgqJsZwbalqNwpXH32PRlzcFjWiVMPc0aI8O7r3acyKpYZ0Kin2gKlfp2OnoA/B06q7P
         wVDA==
X-Gm-Message-State: APjAAAUtMT1smkTqATUVXMQsez+xuEVo3AnyM0dQJvRYL0mhwk7lkE9Q
        gQVtVYMxMGcR6eFK4BZC1IyuBfI=
X-Google-Smtp-Source: APXvYqx4pRchQo/ZEbGw5/vN7Ly+xp2OwhL6CYurwZvqOdFtmbcwU9FCIOyxcscuLiiwdCU1lyMEHQ==
X-Received: by 2002:aca:5083:: with SMTP id e125mr14738919oib.96.1578955958626;
        Mon, 13 Jan 2020 14:52:38 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v14sm4651753oto.16.2020.01.13.14.52.37
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 14:52:37 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219cf
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 16:52:36 -0600
Date:   Mon, 13 Jan 2020 16:52:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-input@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Minkyu Kang <mk7.kang@samsung.com>,
        =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        Oskar Andero <oskar.andero@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2 v4] iio: light: Add DT bindings for GP2AP002
Message-ID: <20200113225236.GA17926@bogus>
References: <20200112111341.21388-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200112111341.21388-1-linus.walleij@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 12 Jan 2020 12:13:40 +0100, Linus Walleij wrote:
> This adds device tree bindings for the GP2AP002 light
> and proximity sensor.
> 
> As with other early proximity sensors (~2010) the light
> sensor and proximity sensors were combined into a single
> component.
> 
> Cc: Stephan Gerhold <stephan@gerhold.net>
> Cc: Minkyu Kang <mk7.kang@samsung.com>
> Cc: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> Cc: Jonathan Bakker <xc-racer2@live.ca>
> Cc: Oskar Andero <oskar.andero@gmail.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v3->v4:
> - Resend with the changes in the main patch.
> ChangeLog v1->v3:
> - Drop the maxitems on the supplies, it is already 1
> - Drop quotes around "alsout"
> - Limit the sharp hysteresis to 8 bits as it should be
> - Use /bits/ 8 in the example so it is correct
> ---
>  .../bindings/iio/light/sharp,gp2ap002.yaml    | 85 +++++++++++++++++++
>  1 file changed, 85 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/sharp,gp2ap002.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
