Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED4F1633B0
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2020 22:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgBRVBc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 18 Feb 2020 16:01:32 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44843 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgBRVBc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 Feb 2020 16:01:32 -0500
Received: by mail-ot1-f68.google.com with SMTP id h9so20908064otj.11;
        Tue, 18 Feb 2020 13:01:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/Qkn6cuX05q9ckSQkSE2Wm9fSdo4DwXw0e9vVR3fD0g=;
        b=USfFxYFa6g+TlszEDFATMzMVR2d+1lLs6qxIpqX+BOB4TEAtV2Sau1q8KoldC+L6b7
         ZxW57ChXscKYHcOPu+vXT8mptR8oyiaWlH2H7ldrbHwn6KXq5k1d65r5SubIjf/aWEDO
         qBCRUJYWxrXTtAPCboQcMNlbs8tDOeIOaqxWMT99ZFe0hxyK0jNzIY/IdKf7JovGN5kD
         0H/JcZ/xdIxKwHes2yJr7U+QwDd2txh5qA5H4HlJuV7KH+xT+TFbh8DHDZzkQ48/+MWa
         8mdDPqB3yoDa1wYilB3fSPQ5rZizCpQ06SAYY8o13WVqgikuL+BPIggeLijJEK2AAq2l
         Gt8A==
X-Gm-Message-State: APjAAAVizXROCsE30lLrZ6hvHaK0i1kP0AFhcJ8qtY3AM2+zcNRic+Yk
        vJGF/cLfoA3WLZsnnnF7oQ==
X-Google-Smtp-Source: APXvYqzliGHidKRoG1fR6TqZPT4hsnNA6zLluyoEJZeEy/c0FxPegzmG8/8F73s19U4pCm1BSaw7wQ==
X-Received: by 2002:a05:6830:10d7:: with SMTP id z23mr17166431oto.114.1582059690302;
        Tue, 18 Feb 2020 13:01:30 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q5sm4379oia.21.2020.02.18.13.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 13:01:29 -0800 (PST)
Received: (nullmailer pid 29601 invoked by uid 1000);
        Tue, 18 Feb 2020 21:01:28 -0000
Date:   Tue, 18 Feb 2020 15:01:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        David Heidelberg <david@ixit.cz>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 2/7] dt-bindings: iio: light: add support for
 Dyna-Image AL3010
Message-ID: <20200218210128.GA29568@bogus>
References: <20200211191201.1049902-1-david@ixit.cz>
 <20200211191201.1049902-3-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211191201.1049902-3-david@ixit.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 11 Feb 2020 20:11:56 +0100, David Heidelberg wrote:
> The Dyna-Image AL3010 is a 16-bit digital ambient light sensor which
> provides a multiple gain function with linear response over a dynamic
> range 1216/4863/19452/77806.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
> v5
>  - drop requirement on interrups and vdd-supply
>  - s/al3010@1c/light-sensor@1c/
>  - dual license also under BSD
> 
>  .../devicetree/bindings/iio/light/al3010.yaml | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/al3010.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
