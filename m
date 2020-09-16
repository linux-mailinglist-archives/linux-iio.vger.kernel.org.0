Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB39226CB1D
	for <lists+linux-iio@lfdr.de>; Wed, 16 Sep 2020 22:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbgIPUWI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Sep 2020 16:22:08 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:39134 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbgIPR3Q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Sep 2020 13:29:16 -0400
Received: by mail-wm1-f44.google.com with SMTP id b79so3869120wmb.4;
        Wed, 16 Sep 2020 10:28:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E47fYlcJkUJ8l3iZf6clnfI3aqBpmWj9zsUvUFymYP4=;
        b=chxz123lmU+GQnQtaRRx4Z2afnjUpzAn6iS26p+C4Qs4L/fuCtlhx4Dbrucl8dZZSU
         QNqwpbK2kvxct99Q2OVrXa4Ye+3bi9e2VxRLv6wSG4ZbwhW8ZiH21UWOrM3LihhQjram
         t2Kc8qC38zmMGUU5sU7h5tM57ZegawoVfZErS9j1MwckA8JUDigteO9vGVQOIvKw9/YD
         +3RTZ61XXJV/9XCZ06CnGqvi6I3dLScuj0LQR9wMOaJr1O9qs5OGN6YFto/gZRSTh9tV
         YlxjcUem5qBj9+ONIVVItoAxscWXUxyCWnJYLvJHjh4FJ/UGU7ihrFYbPl89l3F8Ifu3
         eVqQ==
X-Gm-Message-State: AOAM532rwa3glTN/hbZeuTMRK34crta/78oT4dN11UbUpVeK00eQ51bK
        CUUn+ps6TJJ3GeAuUzWnB8E5aYk218IvFtCC
X-Google-Smtp-Source: ABdhPJweKg9u7dlDmDehpToHUH+j70OfpazvGEE4rWT8Uv/tAw2q657tC8ru2bXuXynBmdptDnBrNA==
X-Received: by 2002:a1c:4d14:: with SMTP id o20mr5723207wmh.74.1600276608983;
        Wed, 16 Sep 2020 10:16:48 -0700 (PDT)
Received: from kozik-lap ([194.230.155.191])
        by smtp.googlemail.com with ESMTPSA id a13sm6462323wme.26.2020.09.16.10.16.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Sep 2020 10:16:47 -0700 (PDT)
Date:   Wed, 16 Sep 2020 19:16:44 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Bakker <xc-racer2@live.ca>,
        =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [RFT 21/25] ARM: dts: s5pv210: move fixed regulators under root
 node in Goni
Message-ID: <20200916171644.GF19427@kozik-lap>
References: <20200907161141.31034-1-krzk@kernel.org>
 <20200907161141.31034-22-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200907161141.31034-22-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Sep 07, 2020 at 06:11:37PM +0200, Krzysztof Kozlowski wrote:
> The fixed regulators are kept under dedicated "regulators" node but this
> causes multiple dtschema warnings:
> 
>   regulators: $nodename:0: 'regulators' does not match '^([a-z][a-z0-9\\-]+-bus|bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'
>   regulators: #size-cells:0:0: 0 is not one of [1, 2]
>   regulators: fixed-regulator@0:reg:0: [0] is too short
>   regulators: fixed-regulator@1:reg:0: [1] is too short
>   regulators: fixed-regulator@2:reg:0: [2] is too short
>   regulators: fixed-regulator@3:reg:0: [3] is too short
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm/boot/dts/s5pv210-goni.dts | 64 +++++++++++++-----------------

Applied.

Best regards,
Krzysztof

