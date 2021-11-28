Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAC8460812
	for <lists+linux-iio@lfdr.de>; Sun, 28 Nov 2021 18:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345602AbhK1RfZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Nov 2021 12:35:25 -0500
Received: from mail-qt1-f179.google.com ([209.85.160.179]:36828 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbhK1RdY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Nov 2021 12:33:24 -0500
Received: by mail-qt1-f179.google.com with SMTP id t11so14061816qtw.3;
        Sun, 28 Nov 2021 09:30:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+jKqrj/WwaNlYQiS2d47yOVc+IwZPP/7wtu0i19l0uk=;
        b=CwN0fS9H1xXmeRDKAOdqtSvAD0b/Xqo4+6eRODFq7Sxa1wq1ioBJOqvjkJYxFmYXv2
         jxmMKEsZZ3/6I8akCNulihjxvWt3fD1ssB9jAdTqABOowema3dIckG7Nzy5SlCET2CEM
         F+7kxHGPYe4V9ebhs21rn7n0+wiOXFSjs/llnhhET4D32q53A9CvVZuSCjabU1qjTQrA
         bvk+iuClrjU4jQ/Jq2Bogym5Xw5Gp9TRxeAweKd+97UkQ7eJxdbu0+ctrDKunZBJVjl0
         zYdOGnVlOwvq1iWM6dhX9lj/YNHZdxnkhTn+KDcruBBw6qszQGHLRArK1+FuDC8NHtsR
         smFA==
X-Gm-Message-State: AOAM530BX3mGI3E0F9tq1Ymi6D/PF3Hie4P4cknrNdoimV/Oxvb4lP8g
        OBQsTUKDmhtYFl89ZxHK4w==
X-Google-Smtp-Source: ABdhPJyDAAP/LbwCCL98ISWrUgbzX1/5IkV/c1emeBrdgvZRdiHZDOC4u4wJJGnqZTnJdZGzPeoz3g==
X-Received: by 2002:a05:622a:1901:: with SMTP id w1mr37564889qtc.134.1638120607335;
        Sun, 28 Nov 2021 09:30:07 -0800 (PST)
Received: from robh.at.kernel.org ([2607:fb90:2edc:4e01:e871:814a:5254:ea69])
        by smtp.gmail.com with ESMTPSA id y9sm7078746qko.74.2021.11.28.09.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 09:30:06 -0800 (PST)
Received: (nullmailer pid 2773123 invoked by uid 1000);
        Sun, 28 Nov 2021 17:30:02 -0000
Date:   Sun, 28 Nov 2021 11:30:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     linux-gpio@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        cosmin.tanislav@analog.com,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v7 2/3] dt-bindings: iio: add AD74413R
Message-ID: <YaO8mttxPXP4Fowm@robh.at.kernel.org>
References: <20211127192510.35723-1-demonsingur@gmail.com>
 <20211127192510.35723-3-demonsingur@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211127192510.35723-3-demonsingur@gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 27 Nov 2021 21:25:09 +0200, Cosmin Tanislav wrote:
> The AD74412R and AD74413R are quad-channel software configurable input/output
> solutions for building and process control applications. They contain
> functionality for analog output, analog input, digital input, resistance
> temperature detector, and thermocouple measurements integrated
> into a single chip solution with an SPI interface.
> The devices feature a 16-bit ADC and four configurable 13-bit DACs to provide
> four configurable input/output channels and a suite of diagnostic functions.
> The AD74413R differentiates itself from the AD74412R by being HART-compatible.
> 
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> ---
>  .../bindings/iio/addac/adi,ad74413r.yaml      | 158 ++++++++++++++++++
>  include/dt-bindings/iio/addac/adi,ad74413r.h  |  21 +++
>  2 files changed, 179 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
>  create mode 100644 include/dt-bindings/iio/addac/adi,ad74413r.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
