Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62E56CEB61
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2019 20:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbfJGSEg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Oct 2019 14:04:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:55660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728031AbfJGSEg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 7 Oct 2019 14:04:36 -0400
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89B69206C0;
        Mon,  7 Oct 2019 18:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570471475;
        bh=a/tQzknOhmzpT+cmi0zru3Okxb6K53nlRWKki8ejYMY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BSPaaHWlukMgVOG2TR6oN2iz8jTqwVmp+i8EhmB5PrGAGku7715laEhDOElBtk0a9
         +XBfArVp8w4E29UFWB1/MCnddDmf7tZQsP68aJRWa52Bcg1MsiobXTx19PhkkFskGf
         kHEJAWkotxSN3jfc8Wt1Yn04aehJNf+wNfArJLfw=
Received: by mail-qk1-f181.google.com with SMTP id x134so13535307qkb.0;
        Mon, 07 Oct 2019 11:04:35 -0700 (PDT)
X-Gm-Message-State: APjAAAW7MWxt6yftQQDCNQhPGhuMue0GhVk79SPmKQtI3B4DfWdvFR+V
        7volN2IIhWP9eKZ3Elw9bJyf22CN83uDY+nYkg==
X-Google-Smtp-Source: APXvYqyc3RB0S5x2d9A+kFi6GPyadpByd7ZFwQbH6O3IVlD6OEpNglf7rl7rMw2PGZpyngtUlaRHfhL/S/P7NAZdECA=
X-Received: by 2002:a05:620a:549:: with SMTP id o9mr25186163qko.223.1570471474614;
 Mon, 07 Oct 2019 11:04:34 -0700 (PDT)
MIME-Version: 1.0
References: <20191006142715.45k64cgw7mzlekm5@arbad> <CAL_Jsq+0SpRVmGJSm5Hw8bQ_zdeJy5wfTb9RM1r=crkiT2uM-Q@mail.gmail.com>
 <20191007170018.673p6fs6mjokihn6@arbad>
In-Reply-To: <20191007170018.673p6fs6mjokihn6@arbad>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 7 Oct 2019 13:04:23 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK-yZnPcb=YPfygK4Y+mJ=JoYq7qWbx04_roAiUD=54Sg@mail.gmail.com>
Message-ID: <CAL_JsqK-yZnPcb=YPfygK4Y+mJ=JoYq7qWbx04_roAiUD=54Sg@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: iio: maxbotix,mb1232.yaml: transform to yaml
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Oct 7, 2019 at 12:00 PM Andreas Klinger <ak@it-klinger.de> wrote:
>
> Hi Rob,
>
> i don't get this error. Is there anything i'm doing wrong here?
>
> ak@arbad:/project/opt-sw/linux-robh$ make O=3D../build-wega-robh/ dt_bind=
ing_check
> make[1]: Verzeichnis =E2=80=9E/project/opt-sw/build-wega-robh=E2=80=9C wi=
rd betreten
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.yaml
>   /project/opt-sw/linux-robh/Documentation/devicetree/bindings/net/adi,ad=
in.yaml:
>   ignoring, error in schema 'adi,fifo-depth-bits'
>   warning: no schema found in file:
>   /project/opt-sw/linux-robh/Documentation/devicetree/bindings/net/adi,ad=
in.yaml
>   /project/opt-sw/linux-robh/Documentation/devicetree/bindings/regulator/=
fixed-regulator.yaml:
>   ignoring, error in schema '0'
>   warning: no schema found in file:
>   /project/opt-sw/linux-robh/Documentation/devicetree/bindings/regulator/=
fixed-regulator.yaml
>     CHKDT   Documentation/devicetree/bindings/iio/proximity/maxbotix,mb12=
32.yaml
>     CHKDT   [...]

It would be in the later stage when dtc builds the exmaple. The
unrelated errors here may be making things error out before that.

BTW, update dtschema and it will fix the first error. The 2nd one is
pending in linux-next still.

Rob
