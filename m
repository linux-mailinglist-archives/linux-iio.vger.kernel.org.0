Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0CBD1B139C
	for <lists+linux-iio@lfdr.de>; Mon, 20 Apr 2020 19:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgDTRyy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Apr 2020 13:54:54 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39228 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbgDTRyy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Apr 2020 13:54:54 -0400
Received: by mail-ot1-f66.google.com with SMTP id m13so8896550otf.6;
        Mon, 20 Apr 2020 10:54:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+Gi26TDtWax7qst8ulcbl7U4YQylmsemnZgiw5cB9Us=;
        b=qHFrach84EMD86oQYsKwdQEZsunZ3rZPFMewmKN6hDR7HyeAB9FPyZzddBF1rs+xxk
         yGu/ApP5iqEmgFN2W33NDuA98dt96JX17hdK5CcI6c1JSljvGzROVVwS+GEk0IVni8uk
         AX+YDxoWbeWNhlkBmmbZaHg0RMkndg+JytEqBCy3BfU5nHMm+UdlPE8rDIHZX8azW4hI
         4qzfjap6lnAD8N1E/V6A9zrcm1V/MlW2SwGrgV5rYvlq+uI1g/OZ84MapsRjzU3qgGPo
         WInNVPBXq+jjEGu7vPXcCWiiOPE5JlLnK9Xjgmx99IoH6vIGqrAEMS6LPPASDqiAY8hF
         u+rQ==
X-Gm-Message-State: AGi0PuZ2e8rBZBXsk/SLf9IuiP3FJ4DHnu+jdPW9Jkc2BLQAbcQgeG4y
        MkjK6Blcct1SlI6fnao+yA==
X-Google-Smtp-Source: APiQypLR/LxJLTBWf2MahE0hcKnBt7LJR3oCpN+jJPHAwDJw/tdZyf7TWfdCOMb35+e8qxQsO1P16w==
X-Received: by 2002:a9d:4e3:: with SMTP id 90mr10762195otm.261.1587405293408;
        Mon, 20 Apr 2020 10:54:53 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f25sm85690oti.2.2020.04.20.10.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 10:54:52 -0700 (PDT)
Received: (nullmailer pid 28270 invoked by uid 1000);
        Mon, 20 Apr 2020 17:54:51 -0000
Date:   Mon, 20 Apr 2020 12:54:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ivan Mikhaylov <i.mikhaylov@yadro.com>
Cc:     Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v9 1/2] iio: proximity: provide device tree binding
 document
Message-ID: <20200420175451.GA27252@bogus>
References: <20200417182053.22213-1-i.mikhaylov@yadro.com>
 <20200417182053.22213-2-i.mikhaylov@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417182053.22213-2-i.mikhaylov@yadro.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 17 Apr 2020 21:20:52 +0300, Ivan Mikhaylov wrote:
> Mostly standard i2c driver with some additional led-current option
> for vcnl3020.
> 
> Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>
> ---
>  .../bindings/iio/proximity/vcnl3020.yaml      | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/vcnl3020.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/proximity/vcnl3020.example.dt.yaml: proximity@13: vishay,led-current-microamp:0:0: 20 is not one of [0, 10000, 20000, 30000, 40000, 50000, 60000, 70000, 80000, 90000, 100000, 110000, 120000, 130000, 140000, 150000, 160000, 170000, 180000, 190000, 200000]

See https://patchwork.ozlabs.org/patch/1272391

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.
