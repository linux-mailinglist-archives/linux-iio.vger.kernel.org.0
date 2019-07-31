Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0B2F7C932
	for <lists+linux-iio@lfdr.de>; Wed, 31 Jul 2019 18:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbfGaQuv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 31 Jul 2019 12:50:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:40264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726669AbfGaQuv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 31 Jul 2019 12:50:51 -0400
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA65A20C01;
        Wed, 31 Jul 2019 16:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564591849;
        bh=CY/0MCpQ2R6VuyvKTw3bMUvovG1rnkErTplcdXO7cuc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=c3f9ELYR6ER59TqzdR9TYoisIDsQpR4Xc0E3tHNoXP53E6cWFY9aAHutew8eyHyRl
         VAET+Xtsd+yfgYlQnMLWjdEuLd3NYoqHOC/VWlvGKgmo7bL1p7XKrvWIuqGZ4i/xPI
         1k/2X0OavLVwOZnPJAgJIaRTGrfrm32+Un1xY8Rc=
Received: by mail-qk1-f181.google.com with SMTP id w190so49743169qkc.6;
        Wed, 31 Jul 2019 09:50:49 -0700 (PDT)
X-Gm-Message-State: APjAAAUdBtEQmpSBU6mWQ5a2Rc3RJMT3OKaa0aF6+RUPwxmOmYIoj03b
        ifvN0mHIK1Gxfh6ICwC7YOVY4t2wtbNJLBNXhA==
X-Google-Smtp-Source: APXvYqxML07Ais4tasXDr2ACM8iA+v6upu/yHzTYw/7nGtC9vm0rJF8A+ki9evcCoW8/ZAGodwm9vkqsJhUU0IB1SJc=
X-Received: by 2002:a37:a48e:: with SMTP id n136mr83750105qke.223.1564591848978;
 Wed, 31 Jul 2019 09:50:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190721175915.27192-1-martin@kaiser.cx> <20190731140706.2765-1-martin@kaiser.cx>
 <20190731140706.2765-2-martin@kaiser.cx>
In-Reply-To: <20190731140706.2765-2-martin@kaiser.cx>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 31 Jul 2019 10:50:36 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK9iuxQEh3s2_AgQhSa19Coq7kSFB497KUMQnjQNU+ELw@mail.gmail.com>
Message-ID: <CAL_JsqK9iuxQEh3s2_AgQhSa19Coq7kSFB497KUMQnjQNU+ELw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] dt-bindings: iio: potentiometer: add max5432.yaml binding
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jul 31, 2019 at 8:07 AM Martin Kaiser <martin@kaiser.cx> wrote:
>
> Add a binding for the Maxim Integrated MAX5432-MAX5435 family of digital
> potentiometers.
>
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
> changes in v4
>  - fix the dt bindings
>    - replace ic20 with i2c
>    - document the reg property
>    - add additionalProperties and required
>
> changes in v3
>  - split dt bindings and driver code into separate patches
>  - use yaml format for dt bindings
>  - fix formatting of parameter lists
>
> changes in v2
>  - use MAX5432_ prefix for all defines
>  - fix indentation
>  - convert void * to unsigned long, not to u32
>    (warning from kbuild test robot)
>
>  .../bindings/iio/potentiometer/max5432.yaml        | 44 ++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/potentiometer/max5432.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
