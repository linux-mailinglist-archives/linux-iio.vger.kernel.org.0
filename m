Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26574F23F7
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2019 02:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbfKGBDH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 6 Nov 2019 20:03:07 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44984 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfKGBDG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 6 Nov 2019 20:03:06 -0500
Received: by mail-oi1-f195.google.com with SMTP id s71so438910oih.11;
        Wed, 06 Nov 2019 17:03:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J3OplQav8pU7rCQ2Rjcrl70h2UJgenEjkB35rUwnLjw=;
        b=ucXnGouAha/7z7CO02t152OJEZcXybhsisIFyHalVatcVm00/sLIQ+sq5iZu6DYlYp
         fN6Pd1bw4VjiyxGpkitcMGDbypwRba81UcDv7WAJxk+J/VfumJ2OQOjOharwKTK3vUm8
         mGXK14CVNlyYMiWcwPkmzTH+A4joT7nQLWeg8ZNZuERa8K6lTE/OirGm/oENwVeaV6p8
         +YVA4JtWe8D/43JPItwSmrGLzNx9hNIvNAtamf3bz0Vxz8L6CXt4/DrzzjDPL9QAFg1C
         k1PmuRx7CPG/jqmrhtVk3mwzKeVmUghQFOp1of0cqLdYHmGQZwNsQs3SdFPplGegQQiy
         UQZg==
X-Gm-Message-State: APjAAAU98YSAQhJVx2ILJMR9GmkdnvXBTESLdtDgYmcdGqQ4SXrqnh8v
        I6R2sETVaraKVVbIPnuj2w==
X-Google-Smtp-Source: APXvYqyMl1DEvue525I9jZEl/zviEi8rAWfGFU4rD14UgBGSSdfcBFbLLJyaPx94bKVjiNxf7PJ7uw==
X-Received: by 2002:aca:dbc3:: with SMTP id s186mr778750oig.130.1573088584162;
        Wed, 06 Nov 2019 17:03:04 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 37sm224434oti.40.2019.11.06.17.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 17:03:00 -0800 (PST)
Date:   Wed, 6 Nov 2019 19:02:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "David S . Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: iio: adc: Migrate MCP3911 documentation
 to yaml
Message-ID: <20191107010259.GA7930@bogus>
References: <20191106111210.6825-1-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106111210.6825-1-marcus.folkesson@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed,  6 Nov 2019 12:12:10 +0100, Marcus Folkesson wrote:
> Rewrite bindings to use json-schema vocabulary.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
> 
> Notes:
>     v2:
>     	- Remove descriptor for reg and spi-max-frequency (Rob)
>     	- Write better description for clocks and vref-supply (Rob)
>     	- Remove max-items for vref-supply
> 
>  .../devicetree/bindings/iio/adc/mcp3911.txt   | 30 --------
>  .../bindings/iio/adc/microchip,mcp3911.yaml   | 71 +++++++++++++++++++
>  MAINTAINERS                                   |  2 +-
>  3 files changed, 72 insertions(+), 31 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/adc/mcp3911.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
