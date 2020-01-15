Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C09113C810
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jan 2020 16:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbgAOPjr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Jan 2020 10:39:47 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44163 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgAOPjq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Jan 2020 10:39:46 -0500
Received: by mail-oi1-f193.google.com with SMTP id d62so15727812oia.11
        for <linux-iio@vger.kernel.org>; Wed, 15 Jan 2020 07:39:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oQF2OHgOU668qHE/qFtSpHWzGnN6zfD/pu9qzKZX2wY=;
        b=Wb7m6XpQINwfGZtKSlzZHYdtL2p3rIfOBfUzZnqW4ZL2lNHDKlO6nPX76JHAEEjVnb
         bDc9P34xMDdGjbJ90KXSADpme35ri9asG22AzHgpubkmlIh8PNUsQoVblvZDHz38CNdG
         5gp1jk+iDFU4+KXWspHMQpARAnIGFidEwF+9e998FF0Fcq2m9ncTc35aI7Ip1tn0vStq
         oCo1ddUFXmPQ4gC1kHGmQ+gCpeM/NR9Qei5D/Iz0km+jI8jE8/7eSeunGX71c4qK01Km
         iasfFW2J+WOkYl5yhM74P+SMq+GiK0Fc5Kuir0W/BOqqy4TzVmSq/43M23kzJj+9Pc5o
         raIQ==
X-Gm-Message-State: APjAAAVoswlb3qW80VKcG+Orc41txrr6AzP+3HuM3SURSU1fSntqBIAI
        /WQPx2OgUVwwsYwtRy8CCPapUF8=
X-Google-Smtp-Source: APXvYqwnxF4T8xJZ0CkEedrchV86pR8ZgCTb3OHysOaG3DchWv9oU7tY41cCPIKdqeEnTPlRf/iQHw==
X-Received: by 2002:aca:cdca:: with SMTP id d193mr298316oig.152.1579102783183;
        Wed, 15 Jan 2020 07:39:43 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i20sm6648585otp.14.2020.01.15.07.39.42
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 07:39:42 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 220379
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Wed, 15 Jan 2020 09:39:41 -0600
Date:   Wed, 15 Jan 2020 09:39:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Robert Yang <decatf@gmail.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] dt-bindings: iio: accel: kxcjk1013: Document
 mount-matrix property
Message-ID: <20200115153941.GA9685@bogus>
References: <20200112203301.30235-1-digetx@gmail.com>
 <20200112203301.30235-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200112203301.30235-2-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 12 Jan 2020 23:33:01 +0300, Dmitry Osipenko wrote:
> The generic IIO mount-matrix property conveys physical orientation of the
> hardware chip.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../devicetree/bindings/iio/accel/kionix,kxcjk1013.txt     | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
