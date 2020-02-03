Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC5CD15042B
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2020 11:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbgBCKZQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Feb 2020 05:25:16 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38084 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbgBCKZQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Feb 2020 05:25:16 -0500
Received: by mail-pg1-f195.google.com with SMTP id a33so7577771pgm.5;
        Mon, 03 Feb 2020 02:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x7n8iYbotY1SSWk8040/LMh/zf8OB99iIkxzC9W3j6c=;
        b=KXu8gdqiB+LLnu0PQxmo71BZx4WS9dIPfHjiaOJd1IfXfU8+pe9Cf96kK87ih9AsP2
         vcm/eDuPmuBOqw3YNn4Q2EwAPOVXqyeHXDPXFk3hbYnqePM9R4SFHHE/uaT/wOdR6iMa
         KE8ipJgAsiX6XmR/XybvKtXaD9iwgUx6sRdbH7dLLKcq2FokaQqtMV7IPT7MAnr/ezLf
         sh9GL5eibY4Tf/899ZUw8MoiZJMNTkYx1SKMD94+ObkEMKCPFH5zYdgEjz8jfocOT0sR
         tmh54ya/yz63T4ZFBTmGdogHE9jvMhe+Qdg5S/yK8YUMUzpEiqm7xqQyg3EyUO8Z04N7
         7+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x7n8iYbotY1SSWk8040/LMh/zf8OB99iIkxzC9W3j6c=;
        b=SStpubXG3iiXThC84kzu5CEeOq41tOopjc6n1+ZDoOtlFcICCssAhNNvI63KpQGoKZ
         MZFBHoXywzTjqfo9urmOB6rilPI1kmVzyOHi9ZMUV4+5crNuQUau8KbBIpX5FA4mD1Sy
         mcvdMXnPjt5Na3LdF/1vwifGZZcL5PLJUTIoDoCaPbz0h3iLG3hGcqCLbf15ZM1rI/GD
         oipXxrjAS2cj8dKh1e2FRNSFYSZzVI6sst/TH9uewZUxm0xU09py0xyefsyNKaohu5dy
         Sc1k2Lu2TPeuCfil+wdnloLz8R46VaAEMvqdcPVlk2ZIY4iuPneUESIgPTlQ6YRrcPAj
         XksQ==
X-Gm-Message-State: APjAAAWVA/kFOh3CfzxHpC4+2Zu1EY1I+aoBbwToukFpoTiuzEx/ZprK
        0OC+HGycdl9z+63P64MGst5v6T9Eg/HaEJWKA/I=
X-Google-Smtp-Source: APXvYqwhkAJi3dNYvGMLuTcLfW2vveiQI8JKmhBuUGJiCPGAfcCK3DHpzSoyLf4aqgppIqD9dK7YAyoVXsCVrnPOLJA=
X-Received: by 2002:a62:1944:: with SMTP id 65mr24861365pfz.151.1580725515953;
 Mon, 03 Feb 2020 02:25:15 -0800 (PST)
MIME-Version: 1.0
References: <20200129142301.13918-1-beniamin.bia@analog.com> <20200129142301.13918-6-beniamin.bia@analog.com>
In-Reply-To: <20200129142301.13918-6-beniamin.bia@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 3 Feb 2020 12:25:07 +0200
Message-ID: <CAHp75Vcvr7RTx1D_qZqSvY5A9irE+4_rSnHC3EFDCfB_MwVn7Q@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] MAINTAINERS: add entry for hmc425a driver.
To:     Beniamin Bia <beniamin.bia@analog.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        biabeniamin@outlook.com, Hartmut Knaack <knaack.h@gmx.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jan 29, 2020 at 4:24 PM Beniamin Bia <beniamin.bia@analog.com> wrote:
>
> Add Beniamin Bia and Michael Hennerich as maintainers for HMC425A
> attenuator.

> +ANALOG DEVICES INC HMC425A DRIVER
> +M:     Beniamin Bia <beniamin.bia@analog.com>
> +M:     Michael Hennerich <michael.hennerich@analog.com>
> +L:     linux-iio@vger.kernel.org
> +W:     http://ez.analog.com/community/linux-device-drivers
> +S:     Supported
> +F:     drivers/iio/amplifiers/hmc425a.c
> +F:     Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml

Had you run parse-maintainers.pl afterwards to see if everything is okay?

--
With Best Regards,
Andy Shevchenko
