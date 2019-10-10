Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45F14D32C9
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2019 22:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbfJJUrx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Oct 2019 16:47:53 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35772 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbfJJUrx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Oct 2019 16:47:53 -0400
Received: by mail-ot1-f66.google.com with SMTP id z6so6120820otb.2;
        Thu, 10 Oct 2019 13:47:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g2NGn0JHqOilhKsSqB3QO+8Vmh7wDxbT9p6+g1mCprE=;
        b=nJZR9HW9Dv2c46lP46u+OSwROftwwj3BufjhfxcQ8PEb8I6zyaN2nQqahcmzYvqNPZ
         2ZjKFIqOULnGw0Md7VrTwx5/6GPZy8DflWJjYw4FDA1bOfOvDe/IneAaSD1Kpk2NkHqA
         6VpqNcJBoT2QxhfRJp3CYJepL5PUN0b2YHCovR4kxxqaQV/tLL4PmTbnRE0pZd3jQFuZ
         Z27TE0zmGcDs1GJ/yKIU+Pu7RXpoK91Db8Tg6SPWJAxWqBvhuMjwI+x2UliKr++inn7U
         P6RzafJbGZ4MUGuPbmM50WUAOd9ks6Q64WxluqfpFYZ5b9VknCKk2xOm/mq7tvgG7lKI
         lEXg==
X-Gm-Message-State: APjAAAXi0is+a4IOeXDdLF3IaMk3vE5wJ2je3pnhMI15HRRSKzi3HlSp
        v8gPTrEGYAYS7PWFxHE0HQ==
X-Google-Smtp-Source: APXvYqwO+SASp9nvuTYNhH5Lei92FxE4O9+patnbNl3BtRfrzxeoEACn9HX6g2Q4lVizs+j/8ybC8A==
X-Received: by 2002:a9d:6c56:: with SMTP id g22mr9306234otq.89.1570740472180;
        Thu, 10 Oct 2019 13:47:52 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v7sm425440oic.9.2019.10.10.13.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 13:47:51 -0700 (PDT)
Date:   Thu, 10 Oct 2019 15:47:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 8/8] dt-bindings: Add max12xx SPI ADC series as
 trivial devices
Message-ID: <20191010204751.GA22206@bogus>
References: <20191007132657.4190-1-miquel.raynal@bootlin.com>
 <20191007132657.4190-9-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007132657.4190-9-miquel.raynal@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Oct 07, 2019 at 03:26:57PM +0200, Miquel Raynal wrote:
> Update the compatible list with three Maxim ADCs compatibles.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../bindings/iio/adc/max1027-adc.txt          | 28 +++++++++++++++++++
>  .../devicetree/bindings/trivial-devices.yaml  |  6 ++++
>  2 files changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/max1027-adc.txt

Devices are supposed to be documented in one place or the other. So 
either make max1027-adc.txt a schema or drop it.

I'm fine either way. Obviously, trivial-devices.yaml is trivial to add 
to, but it does leave some ambiguities. Like is an interrupt required, 
optional or non-existent? What about power supplies? Or what are allowed 
values for spi-max-frequency.

Rob
