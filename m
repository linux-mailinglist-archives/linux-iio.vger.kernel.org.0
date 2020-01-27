Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B053E14A5FD
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2020 15:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbgA0O0x (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Jan 2020 09:26:53 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:43743 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbgA0O0x (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jan 2020 09:26:53 -0500
Received: by mail-ot1-f65.google.com with SMTP id p8so8490029oth.10;
        Mon, 27 Jan 2020 06:26:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=384aXLk+Dp5oNTQmdLCF7Z+jOr9Ua155OMVyKVmomg4=;
        b=VIWewOxjLUuTP2WoCzETvP8DVDjMBREHRfXYK4fGAaCW0XjBk2XtvaYqp309JaBwio
         QK9gp4h5SLvlE5+PQm49FhDpAAuXAv8R6mnywS4qKhJ/0TOv0Th0Pj4hQrH5ngffuhhn
         LspSM1yQQjSQ2kEZAPXfRLz1ROPY7W3plfNd6LkbdfZqxTsX09WjaMYLpiv4O7tIwkn/
         7vL0S8e8xXuH1ZblAG2lkl2Vc1IdlXkKyOf2ImKTZJBydTOi1mKTr2sCm5h6ud/g3gSw
         OJMEssjOvzwKgE950jpviFC/aKmGIO150hXVIRdvOucaYDvCpNKSkDKZcx0MHjP1qDSX
         oB0g==
X-Gm-Message-State: APjAAAVTIqachpf9810jVb+cDA28vOlfSnGvC1WiSuX3J5H8s7QqZ2/Z
        K65Q6KaPjE2vdWOJPRvMs4nDaSM=
X-Google-Smtp-Source: APXvYqyP63MnmHJt0hGWP9PkKahnDDxwFoVmtDIBkx6YXdHnUBlVqA1nwvgSNYg+n1ALMcngCXMc9w==
X-Received: by 2002:a9d:6f0d:: with SMTP id n13mr12889727otq.165.1580135212187;
        Mon, 27 Jan 2020 06:26:52 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n2sm4798369oia.58.2020.01.27.06.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 06:26:51 -0800 (PST)
Received: (nullmailer pid 30592 invoked by uid 1000);
        Mon, 27 Jan 2020 14:26:50 -0000
Date:   Mon, 27 Jan 2020 08:26:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Artur Rojek <contact@artur-rojek.eu>
Subject: Re: [PATCH v2 4/5] dt-bindings: input: Add docs for ADC driven
 joystick.
Message-ID: <20200127142650.GA30045@bogus>
References: <20200126161236.63631-1-contact@artur-rojek.eu>
 <20200126161236.63631-4-contact@artur-rojek.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200126161236.63631-4-contact@artur-rojek.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 26 Jan 2020 17:12:35 +0100, Artur Rojek wrote:
> Add documentation for the adc-joystick driver, used to provide support
> for joysticks connected over ADC.
> 
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>
> Tested-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
>  Changes:
> 
>  v2: - Add `reg` property to axis subnode in order to enumerate the axes,
>      - rename `linux,abs-code` property to `linux,code`,
>      - drop `linux,` prefix from the remaining properties of axis subnode
> 
>  .../bindings/input/adc-joystick.yaml          | 117 ++++++++++++++++++
>  1 file changed, 117 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/adc-joystick.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/display/simple-framebuffer.example.dts:21.16-37.11: Warning (chosen_node_is_root): /example-0/chosen: chosen node must be at root node
Error: Documentation/devicetree/bindings/input/adc-joystick.example.dts:22.31-32 syntax error
FATAL ERROR: Unable to parse input tree
scripts/Makefile.lib:300: recipe for target 'Documentation/devicetree/bindings/input/adc-joystick.example.dt.yaml' failed
make[1]: *** [Documentation/devicetree/bindings/input/adc-joystick.example.dt.yaml] Error 1
Makefile:1263: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1229387
Please check and re-submit.
