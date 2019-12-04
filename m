Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A40411353E
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2019 19:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbfLDS54 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 Dec 2019 13:57:56 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33650 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbfLDS5z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Dec 2019 13:57:55 -0500
Received: by mail-ot1-f67.google.com with SMTP id d17so262972otc.0;
        Wed, 04 Dec 2019 10:57:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TyFlWZtZeRnOIyikDPfUJupGzxrSsorOBrT8gOUOV5w=;
        b=UUZaNQowzSRR2f2MZOIqeklA5y9J6oI+kHQSsEezq4NzzwXLtJ743wl4MXGz7Ax6au
         1m22x+9gvTH3hfdtFdzk7KLiSo2cmW0EZyamdEKUO6JaFWDE3VibmjhNbbeqhskyx14x
         coaPdasAcYCP1HIIgW3s8hFhMN5FmcjHgZGeq3AMjtXUGxXU33ibN+k1/9CaJnlKhpzd
         TqcCdA5rsuSSPQUoD2hsjDJG1cEaN7mKpjAgKuxWHA0zN3RkvTxrwIek2hWxNYGLNxgQ
         hCjpASN+YZhlVJMUs6ty46VuMVWcRz/+y5QBrdtJUJ+fdxBnjC9cBbmFUjiMrKYP0YHg
         Gx2Q==
X-Gm-Message-State: APjAAAU/Kn8SSlg4Oc26o6aoPwBtouny/GvIlbR8CPYmO1/F5l74rCk1
        u3cfhg9Syz/J5o0lZhPtHA==
X-Google-Smtp-Source: APXvYqzLrsljAw6xaQR9Yy1mWF3DkGaOVeVWuG61van3Eri4fGDE3iohUXta2mlOKmmOk1xZ5gGWuw==
X-Received: by 2002:a05:6830:1cf:: with SMTP id r15mr3876151ota.231.1575485874840;
        Wed, 04 Dec 2019 10:57:54 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i7sm2571659oib.42.2019.12.04.10.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 10:57:54 -0800 (PST)
Date:   Wed, 4 Dec 2019 12:57:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc:     jic23@kernel.org, dragos.bogdan@analog.com,
        alexandru.ardelean@analog.com, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: ad7292: fix channel
 constraint
Message-ID: <20191204185753.GA19409@bogus>
References: <20191204155918.5ot4tplceqjeul6a@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191204155918.5ot4tplceqjeul6a@smtp.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Dec 04, 2019 at 12:59:23PM -0300, Marcelo Schmitt wrote:
> Change items property of AD7292 channels to correctly constrain their
> quantity.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> ---
> Changelog V2
> - Shortened the message to make it closer to 50 columns.
> 
>  Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

I think Jonathan already applied this series.

> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
> index b68be3aaf587..18f1032b86f3 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7292.yaml
> @@ -53,7 +53,8 @@ patternProperties:
>          description: |
>            The channel number. It can have up to 8 channels numbered from 0 to 7.
>          items:
> -          maximum: 7
> +          - minimum: 0
> +            maximum: 7
>  
>        diff-channels:
>          description: see Documentation/devicetree/bindings/iio/adc/adc.txt
> -- 
> 2.23.0
> 
