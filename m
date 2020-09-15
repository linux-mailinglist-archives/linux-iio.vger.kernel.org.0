Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A49DB26AD3C
	for <lists+linux-iio@lfdr.de>; Tue, 15 Sep 2020 21:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbgIOTNR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Sep 2020 15:13:17 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:33176 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbgIOTCC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Sep 2020 15:02:02 -0400
Received: by mail-il1-f195.google.com with SMTP id x2so4091901ilm.0;
        Tue, 15 Sep 2020 12:02:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=10I5+fMmPEEzForz80NGynm9bLNuzz363eyFd54ZBxE=;
        b=Q3MrvxHDSPvXYCmDHBj3b4YlKnCGE8G5qEjklhdLju6AXv0NfVPFXcR0JQj6V+KARG
         3JrJO72MEG30Dk6jTGepKXoMwhUsjJvzwpvaEXxfo9yV6hMOxOIWCHgLHNSJ9+MkVfJn
         ZazvxlrZ980pYpLmt5nuHmf4i9NoNJ7pd8IwECIy36/3zSLPndjcpCW+yfTxydbwMCta
         6aPvonI7jkNDi5/MRQhWqBJuiK7Lc+JuC59AzJlYjYTR620UlMkiRD5T/0MIcOIzmk2y
         GSQZRbWFXJBtKfkyrPZGqz9w8X8IcZe0wPYYkDloM+/pz1joGgI3oWzRxNb2fTZEqOXP
         xssA==
X-Gm-Message-State: AOAM53157QfEHbmhSChuyZt6VIFS317PIJPAwINUULIiYOnrjBcXHbs/
        2QiepXUnUYzDlzhICnU0l0vhj98mk1Bci6Q=
X-Google-Smtp-Source: ABdhPJzcUSrz/WHZ87chTUlj/m9Gk4HJj2HzYY6MwnUtGyFM0wfltv90V6icwdJbzKIE7TgDyxfY/A==
X-Received: by 2002:a92:6b04:: with SMTP id g4mr17603879ilc.203.1600196522198;
        Tue, 15 Sep 2020 12:02:02 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id m18sm9222422iln.80.2020.09.15.12.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 12:02:01 -0700 (PDT)
Received: (nullmailer pid 2314862 invoked by uid 1000);
        Tue, 15 Sep 2020 19:02:00 -0000
Date:   Tue, 15 Sep 2020 13:02:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     devicetree@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 03/20] dt-bindings:iio:adc:st,stmpe-adc yaml conversion
Message-ID: <20200915190200.GA2314807@bogus>
References: <20200909175946.395313-1-jic23@kernel.org>
 <20200909175946.395313-4-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909175946.395313-4-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 09 Sep 2020 18:59:29 +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Conversion from freeform text to yaml.
> One oddity in this binding is that, for historical reasons it requires
> the node name to be stmpe_adc.  I've put that in the decription field
> but I'm not sure if there is a better way to specify this?
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Stefan Agner <stefan@agner.ch>
> ---
>  .../bindings/iio/adc/st,stmpe-adc.yaml        | 45 +++++++++++++++++++
>  .../devicetree/bindings/iio/adc/stmpe-adc.txt | 21 ---------
>  2 files changed, 45 insertions(+), 21 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
