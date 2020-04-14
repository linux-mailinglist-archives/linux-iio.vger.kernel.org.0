Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 324D81A87DA
	for <lists+linux-iio@lfdr.de>; Tue, 14 Apr 2020 19:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502497AbgDNRpK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Apr 2020 13:45:10 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34949 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502278AbgDNRpG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Apr 2020 13:45:06 -0400
Received: by mail-oi1-f193.google.com with SMTP id b7so8592525oic.2;
        Tue, 14 Apr 2020 10:45:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wIbqVXLkImZU9C3g/BO7DfFyuoNPsjlmSkXF07h/gBY=;
        b=XWl2G8xqOAt7soiZ7Lp1aCHdxhaSJOcYGqSxP5Q04UdX5dgCNeHixCF1kl1QKtZOL9
         re8MYXS/3eADQOpUdruwDRe93fJ4ROmaEvibYL/JA8NiMLdP25gEg8/wTbZLwx/0XjXX
         hBjEy9+FlSiTnJkEfyKmrSmC0/9eZzgW3wIihrcuFPKu1dWg2kLCiGVH3DizGxtWzatK
         sWL9JBy/xve6znsZZ7bHbB4nB+kVxruN8SnjWMlewHsiDNOACnUBv9fRu29a37h3/ULS
         QR3zzAgZ+bTyOyIT82NV4ENas5YAtM6eGJU7FXe2di5DhGPkA9fpCjT+80qd+jEe827Y
         7lIQ==
X-Gm-Message-State: AGi0PuYNOPVrkmvwdf+spGKabYMiSaDHf05Uka6nnIzPmmvLXRs2Rotd
        Lke7Kfb1KHf9zl2mCOIGm5YiW6w=
X-Google-Smtp-Source: APiQypKHCvmsvLGKSNqDdfy8u+6Z7stb8ojJ8PGZu95BPq/D5H8nZreBSucp1qiYVieyWvZ+UaOUZg==
X-Received: by 2002:aca:add2:: with SMTP id w201mr16202047oie.53.1586886305691;
        Tue, 14 Apr 2020 10:45:05 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w15sm5615942oiw.43.2020.04.14.10.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 10:45:04 -0700 (PDT)
Received: (nullmailer pid 11767 invoked by uid 1000);
        Tue, 14 Apr 2020 17:45:03 -0000
Date:   Tue, 14 Apr 2020 12:45:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alexandru Lazar <alazar@startmail.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        Alexandru Lazar <alazar@startmail.com>
Subject: Re: [PATCH v7 1/2] dt-bindings: iio: adc: Add MAX1241 bindings
Message-ID: <20200414174503.GA11705@bogus>
References: <20200403121323.1742-1-alazar@startmail.com>
 <20200403121323.1742-2-alazar@startmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403121323.1742-2-alazar@startmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri,  3 Apr 2020 15:13:22 +0300, Alexandru Lazar wrote:
> Add device-tree bindings documentation for the MAX1241 device driver.
> 
> Signed-off-by: Alexandru Lazar <alazar@startmail.com>
> ---
>  .../bindings/iio/adc/maxim,max1241.yaml       | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max1241.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
