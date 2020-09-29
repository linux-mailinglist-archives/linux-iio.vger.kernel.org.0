Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09A4727D630
	for <lists+linux-iio@lfdr.de>; Tue, 29 Sep 2020 20:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbgI2SxE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Sep 2020 14:53:04 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37480 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbgI2SxE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 29 Sep 2020 14:53:04 -0400
Received: by mail-ot1-f67.google.com with SMTP id o8so5520202otl.4;
        Tue, 29 Sep 2020 11:53:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4vsmavC+t3jWUrFxvQlPGqyQgVM8r2sGoRhi8Fg4sBM=;
        b=SuXWq1TydqPIFCe3BogaRh18auBBwFROTdlceF66BzpNDNeUbZ6cpwabBp1h8hkFgL
         uVKP1nHBvtTQf+rqbGicW8LhZGChDJJiMueiWc0nbs4u0z5Kt61++JY3iMmQcn57099M
         JAdNEw4DhPAc4vn0UXArql2En3BqA8evxMvjcGAs1ZJC7IeXVzhsdcsjH1nimInA58LE
         5fyAeMdtuLY/tC1TuFyE9T8O4mTpVLMfPyvvD8Y+uLyoVJ66a1xchALue7KILHkQPge7
         qzHtsVMMDDds3yHL7gWVjfw0VsFFRXsNqnvgI+qEnb8FFiwrJHCA/ONngyPryF9VG2ik
         A6WA==
X-Gm-Message-State: AOAM530dbhgW1sVkz0MV+CliHVydeLQCoT1ZdanmpSONWYVRytI8DuX6
        8sj3npXsZIZ9NSEaf2Iszg==
X-Google-Smtp-Source: ABdhPJzz5OdfUnY1Kgb1WnljeQVvq4G0+uP+WdbRgqCe9+rnn7s/KTStarZQi4uDjVCSOgzc5VHIrg==
X-Received: by 2002:a9d:6f98:: with SMTP id h24mr3664200otq.101.1601405582108;
        Tue, 29 Sep 2020 11:53:02 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q81sm1176914oia.46.2020.09.29.11.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 11:53:01 -0700 (PDT)
Received: (nullmailer pid 955668 invoked by uid 1000);
        Tue, 29 Sep 2020 18:53:00 -0000
Date:   Tue, 29 Sep 2020 13:53:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Michael Auchter <michael.auchter@ni.com>
Cc:     linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/3] dt-bindings: iio: dac: ad5686: add binding
Message-ID: <20200929185300.GA955613@bogus>
References: <20200924195215.49443-1-michael.auchter@ni.com>
 <20200924195215.49443-3-michael.auchter@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924195215.49443-3-michael.auchter@ni.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 24 Sep 2020 14:52:14 -0500, Michael Auchter wrote:
> Add a binding for AD5686
> 
> Signed-off-by: Michael Auchter <michael.auchter@ni.com>
> ---
> Changes since v1:
> - Keep supported device sorted
> - fix adc -> dac typo in schema path
> since v2:
> - drop address-cells and size-cells from binding doc
> - add "additionalProperties: false"
> - end with ...
> 
>  .../bindings/iio/dac/adi,ad5686.yaml          | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
