Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4598F221766
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jul 2020 23:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgGOV5r (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Jul 2020 17:57:47 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38258 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgGOV5q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Jul 2020 17:57:46 -0400
Received: by mail-io1-f65.google.com with SMTP id l1so3915939ioh.5;
        Wed, 15 Jul 2020 14:57:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N6Iu8tXIKEH22KMPgge73RoyVtlkQudt5QpV2oi/N6U=;
        b=qTbuREqNoNmtFboIuyP9RjMu8Uaq6ImvD+P8eURi2lw67mX5+Z28hHlFHUeB46Do3P
         GpMoBWvKjmH7Fo0UwTUzoZVZ+azlDi503X64h9XP4OpzzSkvvlwDZFCeLEHg7GkeeHs3
         PPo+C/PiDv8I+kpisyAYjQ+Y9MYBQTr/4s4dm0XBuus1al3ChHxsELWLm9DjUM42nmKS
         EqwL+uUDG5kVNg5N0i3HieEM4z7vQ86QZzlqfNKhcR9x7iyJo4P4uuNQoVbe/Da83uzi
         sWFwQpqeuvKdzi7qiX9/rgdM3B+elFsGTV8ZeVBJVNqJje/oj37F0JteIxkaVX58dUZa
         1Jxw==
X-Gm-Message-State: AOAM5302UYENitJ9OsJDsR3bJv/HkSP4YX0txKK6XXj684hOlAFbj9pl
        Vd0tBdlkWOWtVBrPNvNaaKrtrpLg9w==
X-Google-Smtp-Source: ABdhPJwhSmDunOeHZ+nt8rr5OtpW1EIJTQ30bfzE3g5ZWeNz5kJnrhpCE1VGQ68lU5LdFl51+GtEfQ==
X-Received: by 2002:a6b:7f42:: with SMTP id m2mr1355879ioq.181.1594850265984;
        Wed, 15 Jul 2020 14:57:45 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id b24sm1730791ioh.6.2020.07.15.14.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 14:57:45 -0700 (PDT)
Received: (nullmailer pid 888066 invoked by uid 1000);
        Wed, 15 Jul 2020 21:57:44 -0000
Date:   Wed, 15 Jul 2020 15:57:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sean Nyekjaer <sean@geanix.com>
Subject: Re: [PATCH] dt-bindings: iio: ti,ads8688 yaml conversion
Message-ID: <20200715215744.GA879805@bogus>
References: <20200705131720.240574-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200705131720.240574-1-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jul 05, 2020 at 02:17:20PM +0100, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Fairly simple binding.  Most of the changes were filling in information
> not previously found in the binding.  I dropped the previous explicit
> mention of spi-max-frequency as that is covered by the generic SPI
> binding.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Sean Nyekjaer <sean@geanix.com>
> ---
> 
> Sean, are you fine with being explicitly listed at the maintainer
> of this binding?  Previously we didn't have that formally laid
> out in the old txt bindings but it's now a required field.
> 
> I'm going to slowly work my way through some of the simpler yaml conversions
> over the next few months.   Of course I welcome anyone else taking
> some of these on but for purposes of review, please keep it to only
> a few at a time.

Actually, I'd really prefer a bunch at a time if it is by one person. 
Not because I need more to review :P, but then all the mistakes are the 
same and can be fixed in one go. I have a script[1] I use that does some 
of the boilerplate, but not the hard part (properties). It works best if 
you tweak the template with what's common for a set of bindings.

Rob

[1] https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git/commit/?h=yaml-bindings-v2
