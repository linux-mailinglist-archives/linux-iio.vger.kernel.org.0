Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9DB9154DFD
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2020 22:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgBFVe3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Feb 2020 16:34:29 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41177 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbgBFVe3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 Feb 2020 16:34:29 -0500
Received: by mail-pg1-f196.google.com with SMTP id l3so3396831pgi.8;
        Thu, 06 Feb 2020 13:34:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F+A5Nf6jojAXkMgoriymn50UInA7zWvy6KKfk99TRuU=;
        b=I5rCqRlE1E954co/J/Umj2y2j4f5TvQtqattYqLiKLhwnEyjyVskPc0Sm5Draz5JH3
         wQXDz2Yf9TIwM1TupAzRQ/gtniUV0QXQTJ4PoGyxpFMWmH3dpsWepxFxjksbVNSWyNOJ
         82AWVWNUj+MY/EuVtamf2YyUEpcNOqDWQDvZtFWD1GemjIyq/ES4Dz0MUawV5HmNCeE7
         aCyBgHi9kVIYosxdq+Xj+tC/dfaH2d9EUimCSHSdRtJCqvlf3yyaOhntO99GZFNWVI35
         SJck0Sl2EetF7CGI8mUBUa1iUD0Wzez30NjeXYBroh6Ay5YvjY+gpJ+NB7ThQzA9XSap
         SFfA==
X-Gm-Message-State: APjAAAX+hygaLNEmzGeKM6MNfrELXkSNQi4bdQdV0kRa/JxWzgF8UBed
        BTYopnaR8rLowKDb+SI8hQ==
X-Google-Smtp-Source: APXvYqwYy/+XAYue+7uOsYCEUX9rEtJ+clY7s1oHaWp5FDC4KLqoEfxmAKeYxPfZNh4BMD/dzqO/UQ==
X-Received: by 2002:a63:8a42:: with SMTP id y63mr5814347pgd.266.1581024868913;
        Thu, 06 Feb 2020 13:34:28 -0800 (PST)
Received: from rob-hp-laptop (63-158-47-182.dia.static.qwest.net. [63.158.47.182])
        by smtp.gmail.com with ESMTPSA id w26sm332548pfj.119.2020.02.06.13.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 13:34:28 -0800 (PST)
Received: (nullmailer pid 14123 invoked by uid 1000);
        Thu, 06 Feb 2020 21:34:27 -0000
Date:   Thu, 6 Feb 2020 14:34:27 -0700
From:   Rob Herring <robh@kernel.org>
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, biabeniamin@outlook.com,
        knaack.h@gmx.de, mark.rutland@arm.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 4/5] dt-bindings: iio: amplifiers: Add docs for
 HMC425A Step Attenuator
Message-ID: <20200206213427.GA12507@bogus>
References: <20200206151149.32122-1-beniamin.bia@analog.com>
 <20200206151149.32122-4-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200206151149.32122-4-beniamin.bia@analog.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Feb 06, 2020 at 05:11:48PM +0200, Beniamin Bia wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> Document support for Analog Devices MC425A Step Attenuator.
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
> ---
> Changes in v5:
> -minItems added for ctrl_gpios
> 
>  .../bindings/iio/amplifiers/adi,hmc425a.yaml  | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
