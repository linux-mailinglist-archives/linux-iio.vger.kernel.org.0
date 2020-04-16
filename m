Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 492C71AD060
	for <lists+linux-iio@lfdr.de>; Thu, 16 Apr 2020 21:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731077AbgDPTcG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 Apr 2020 15:32:06 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:33367 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728664AbgDPTcF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Apr 2020 15:32:05 -0400
Received: by mail-oo1-f66.google.com with SMTP id b17so906700ooa.0;
        Thu, 16 Apr 2020 12:32:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G2KfsHLol0MxR420xNgeMgYQ50fxqR1O3iC2ZHpUZCI=;
        b=XlQRNX46xNOgIpzbJem5CSH6woGZBYzcSHE3vXyRWHNgBa07OZbPNzgCxWPBz+9pme
         S5iefyIjt4j8OupGfhtqKOYcbz8/SETcwtiVMVW5cKJgZPjUQAmmGODnSEDt2kNyICmw
         52PkbeGTqkHHi2UcMSnocjifLHPn/mpTb6VVXOW6xYn1R/UjhNBLn6FL+X2+gsitqM3x
         KbtQJoJ84oCbA+N2VLolAprct3zK2Mv6t7nkkaEfefDz8Ul/ZLAwFIje0SbUhMpughkV
         gXs0iyGCWki9m5KAVjOm6mNCe9/rA8JJCyr/lzIlFS4HXEKV8jV9lyUo/dBO++pcD9Dn
         dPDQ==
X-Gm-Message-State: AGi0PubK8GJPLiF2UAr5TGLFtY0Kr8Rzh8S4nLjnAXH21hA+Z5UC2OBa
        dZzyyawkgIUeZe/YRXBgMp4MHmw=
X-Google-Smtp-Source: APiQypIkMfpzlk1lmK+EBTOhD1SsnV9Gj8mGtLRMMEgrPlQkC3YqpIsnDV4DJjgAdynWvj140tiheA==
X-Received: by 2002:a4a:95ee:: with SMTP id p43mr27323868ooi.24.1587065523461;
        Thu, 16 Apr 2020 12:32:03 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t10sm1236678oou.38.2020.04.16.12.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 12:32:02 -0700 (PDT)
Received: (nullmailer pid 21598 invoked by uid 1000);
        Thu, 16 Apr 2020 19:32:01 -0000
Date:   Thu, 16 Apr 2020 14:32:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     alexandru.tachici@analog.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, jic23@kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: iio: dac: AD5570R fix bindings errors
Message-ID: <20200416193201.GA21490@bogus>
References: <20200416115848.56156-1-alexandru.tachici@analog.com>
 <20200416115848.56156-3-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416115848.56156-3-alexandru.tachici@analog.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 Apr 2020 14:58:48 +0300, <alexandru.tachici@analog.com> wrote:
> From: Alexandru Tachici <alexandru.tachici@analog.com>
> 
> Replaced num property with reg property, fixed errors
> reported by dt-binding-check.
> 
> Fixes: ea52c21268e6 ("iio: dac: ad5770r: Add AD5770R support")
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
> ---
>  .../bindings/iio/dac/adi,ad5770r.yaml         | 82 +++++++++----------
>  1 file changed, 39 insertions(+), 43 deletions(-)
> 

Applied, thanks.

Rob
