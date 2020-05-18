Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A50D21D8970
	for <lists+linux-iio@lfdr.de>; Mon, 18 May 2020 22:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgERUls (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 May 2020 16:41:48 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36016 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgERUls (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 May 2020 16:41:48 -0400
Received: by mail-io1-f66.google.com with SMTP id k6so12224530iob.3;
        Mon, 18 May 2020 13:41:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gPZ7HwLu+ZKuhC4Z7Pkuo4nBmBsOY1+VIA/NUsuh/DA=;
        b=hPnl35yePgl8YdiOdSELn7D9E2qQpli8lL7m/SRHQjlBgmELowWFwfnian+6lmNsum
         4Rcr3bqQ6k117t/0FpH2Ee70WRhVeD5BgDktqDtBudEGe3neJoFQtkefmlA7rb12HS4p
         4tLlpAWAsoDMTPWVldk4AFIAgNO5EBEXq3ADCUCp0onhMn73lrAMhagzFWKLrF/b5Z1D
         xrDLY7coe5l3pAqEUfHEJOwQBahMJDJxrdTL9VUbhsSKFixNo0Q41H/Xu6kpJHPbUsU5
         QSRXe5ic51p1I/xD7Yp/FQ53+bD8doWc4rnhyp4Zo4zK+HR3o4ajLnhU/RvoBs4YAIrt
         YAtg==
X-Gm-Message-State: AOAM532AehzK4vLrMtnYBbmpvQ7G4kT8TgeZneAVG8uWbhIABkitYEJQ
        h6BbwN1j/sVdEH3xH7MHfQ==
X-Google-Smtp-Source: ABdhPJxEyNCVrlRsyqtmHbcvip7RB0j/NMJOkoIw9BOe8G2f9o9OXhHUrDCilvK3zRKkp7L7ICe24A==
X-Received: by 2002:a02:1746:: with SMTP id 67mr16973423jah.103.1589834506239;
        Mon, 18 May 2020 13:41:46 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id s22sm4249181iow.40.2020.05.18.13.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 13:41:45 -0700 (PDT)
Received: (nullmailer pid 11333 invoked by uid 1000);
        Mon, 18 May 2020 20:41:44 -0000
Date:   Mon, 18 May 2020 14:41:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ivan Mikhaylov <i.mikhaylov@yadro.com>
Cc:     linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        linux-iio@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v14 1/2] dt-bindings: proximity: provide vcnl3020 device
 tree binding document
Message-ID: <20200518204144.GA11276@bogus>
References: <20200510184537.10335-1-i.mikhaylov@yadro.com>
 <20200510184537.10335-2-i.mikhaylov@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200510184537.10335-2-i.mikhaylov@yadro.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 10 May 2020 21:45:36 +0300, Ivan Mikhaylov wrote:
> Mostly standard i2c driver with some additional led-current option
> for vcnl3020.
> 
> Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>
> ---
>  .../iio/proximity/vishay,vcnl3020.yaml        | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/vishay,vcnl3020.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
