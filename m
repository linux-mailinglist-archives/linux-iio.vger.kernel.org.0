Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDD18413819
	for <lists+linux-iio@lfdr.de>; Tue, 21 Sep 2021 19:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbhIURLu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Sep 2021 13:11:50 -0400
Received: from mail-oo1-f51.google.com ([209.85.161.51]:44019 "EHLO
        mail-oo1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbhIURLt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Sep 2021 13:11:49 -0400
Received: by mail-oo1-f51.google.com with SMTP id l17-20020a4ae391000000b00294ad0b1f52so7274521oov.10;
        Tue, 21 Sep 2021 10:10:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S4rWK627e6yBDbCEhLg6VsNoB81RgebdS3Ln+6wAGas=;
        b=XDlNonLeRIdTMktqjNRbqF+SY16/BGD9K+RZ2jN/S73dF6EUPsXFmXan+RiMB6uyN4
         fFz0JEeHJ1nl8VCyNh9iI+eRGL7VxS0pLU5kLj7+fVXRwnDVSDayDDA+i4lkke6bhvjE
         gZ2I3DND1pnMbOL2pCo4DnHgfDG71lbzR2MdXpcQlY4WlIT/ZspW1/RXQCgnNT5NRV4r
         yKqvS4cxNLI/MoSOeJ2mSeBjJs8eVZzV2AuUUDSl3/+R8Z+nVzXP+wAL8veQZmD/cTTn
         OTp+zlneqrUoOxfgq+iVtdpWDBlKF6dMVNfukQK3r/rmytDQoz25knn2fPwSuL8wlG6q
         GwLg==
X-Gm-Message-State: AOAM5304xQHaS5hJrl4tcLbMJc129gfsL4mUvA7UJsso7VRwybB1QJzE
        tjlzi6167kxyNB9MIoSnxg==
X-Google-Smtp-Source: ABdhPJws4TdO+DPNS83SxM7XXfOVzOeooClPFMk6APULxosklf1aAoTwygi1il30jNMUX7PawpRkzg==
X-Received: by 2002:a4a:52c4:: with SMTP id d187mr10680196oob.53.1632244221024;
        Tue, 21 Sep 2021 10:10:21 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id h15sm372163ots.2.2021.09.21.10.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 10:10:19 -0700 (PDT)
Received: (nullmailer pid 2967390 invoked by uid 1000);
        Tue, 21 Sep 2021 17:10:17 -0000
Date:   Tue, 21 Sep 2021 12:10:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Olivier Moysan <olivier.moysan@foss.st.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        alsa-devel@alsa-project.org,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/7] dt-bindings: iio: adc: add nvmem support for vrefint
 internal channel
Message-ID: <YUoR+Z5HEE56odzj@robh.at.kernel.org>
References: <20210908155452.25458-1-olivier.moysan@foss.st.com>
 <20210908155452.25458-3-olivier.moysan@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210908155452.25458-3-olivier.moysan@foss.st.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 08 Sep 2021 17:54:47 +0200, Olivier Moysan wrote:
> Add support of nvmem. This allows to retrieve calibration data from OTP
> for vrefint internal channel.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> ---
>  .../devicetree/bindings/iio/adc/st,stm32-adc.yaml         | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
