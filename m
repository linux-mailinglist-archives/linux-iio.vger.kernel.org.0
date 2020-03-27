Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 190BC19602D
	for <lists+linux-iio@lfdr.de>; Fri, 27 Mar 2020 22:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbgC0VFm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 Mar 2020 17:05:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:52712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727352AbgC0VFl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 27 Mar 2020 17:05:41 -0400
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3F2A2074A;
        Fri, 27 Mar 2020 21:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585343141;
        bh=k6qmyW97YGA1y4XcZyq/RlW4XCWHs8OoW8pQlNO23/I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2kDM2fILBoLG/958xBtNYyVMLmBxMhy2RFG8YffVdLBjIFOeQrO8bEf9AYPoVXbHB
         U0zKTEmG6kHt2UKACR+vDgIYkoh4VGEc55Vix0vMWWfrWwIzV0/pKu6GMKVubHdf0H
         BjA2BndXrwvrLEHuftZIqVRHXlYFU4896/KSZTsU=
Received: by mail-qt1-f176.google.com with SMTP id i3so9824212qtv.8;
        Fri, 27 Mar 2020 14:05:40 -0700 (PDT)
X-Gm-Message-State: ANhLgQ3yO/txPo5SuNu+9YLjuX8u0t/cr3yljP7Vt2YJia+wIyB9Pmvh
        pgksWm8JZHkec3GfNs1Ys4o2cMu/Fbv7jiQxtA==
X-Google-Smtp-Source: ADFU+vtvqz5AI4wH7P3cIuqZB25uwXMJTnHRkOu86W3BaXrP190mY4bBYCobUgQbF2yoqkp07GyxKABJIEepzVVyjJw=
X-Received: by 2002:ac8:1b33:: with SMTP id y48mr1314603qtj.136.1585343140157;
 Fri, 27 Mar 2020 14:05:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200327131825.23650-1-festevam@gmail.com> <20200327131825.23650-2-festevam@gmail.com>
In-Reply-To: <20200327131825.23650-2-festevam@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 27 Mar 2020 15:05:27 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLeZoJ3qRuVFs7wLD+WtwY4Yw4DKiXi=spk9w6nxyg8FQ@mail.gmail.com>
Message-ID: <CAL_JsqLeZoJ3qRuVFs7wLD+WtwY4Yw4DKiXi=spk9w6nxyg8FQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: iio: dac: ad5770r: Remove unneeded unit names
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Mar 27, 2020 at 7:18 AM Fabio Estevam <festevam@gmail.com> wrote:
>
> The following warnings are seen with 'make dt_binding_check':
>
> Documentation/devicetree/bindings/iio/dac/adi,ad5770r.example.dts:29.35-32.27: Warning (unit_address_vs_reg): /example-0/spi/ad5770r@0/channel@0: node has a unit name, but no reg or ranges property
> Documentation/devicetree/bindings/iio/dac/adi,ad5770r.example.dts:34.35-37.27: Warning (unit_address_vs_reg): /example-0/spi/ad5770r@0/channel@1: node has a unit name, but no reg or ranges property
> Documentation/devicetree/bindings/iio/dac/adi,ad5770r.example.dts:39.35-42.27: Warning (unit_address_vs_reg): /example-0/spi/ad5770r@0/channel@2: node has a unit name, but no reg or ranges property
> Documentation/devicetree/bindings/iio/dac/adi,ad5770r.example.dts:44.35-47.27: Warning (unit_address_vs_reg): /example-0/spi/ad5770r@0/channel@3: node has a unit name, but no reg or ranges property
> Documentation/devicetree/bindings/iio/dac/adi,ad5770r.example.dts:49.35-52.27: Warning (unit_address_vs_reg): /example-0/spi/ad5770r@0/channel@4: node has a unit name, but no reg or ranges property
> Documentation/devicetree/bindings/iio/dac/adi,ad5770r.example.dts:54.35-57.27: Warning (unit_address_vs_reg): /example-0/spi/ad5770r@0/channel@5: node has a unit name, but no reg or ranges property
>
> Fix them by removing the unneeded unit addresses.

Actually, we want to use 'reg' instead of 'num'. Alexandru is
attempting to fix[1].

But looks like you found another issue with patch 1.

Rob

[1] https://lore.kernel.org/linux-iio/CAL_JsqKFdcACQtXd5h=4Pxbij+=uoHr2rLTFZMq4fVX8ph398g@mail.gmail.com/
