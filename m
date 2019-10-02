Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC095C8B99
	for <lists+linux-iio@lfdr.de>; Wed,  2 Oct 2019 16:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725860AbfJBOoZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Oct 2019 10:44:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:50338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725766AbfJBOoZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 2 Oct 2019 10:44:25 -0400
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 784D721920;
        Wed,  2 Oct 2019 14:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570027463;
        bh=DXtCTSlv8DdQz8r7Ra8f1GwoLMAnlT9qlLL5Oq3LgJg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=A/19I8vcFhloBvzKXmq9K5Ho44Zz7GYmbeywp4SJjiLpHUhTsZ93pOKAinuSA3niY
         gbOvvW4BHXAsX6WuW1K9PaHXUNG88o/gv9hdX/ue5eZQrQh57pGWRuspGTzYEzyg/3
         ODEnGjDZr8byc6DF8SGcbmuV2s7Z5aI2eGh1ZfzA=
Received: by mail-qt1-f174.google.com with SMTP id f7so26658872qtq.7;
        Wed, 02 Oct 2019 07:44:23 -0700 (PDT)
X-Gm-Message-State: APjAAAWL7ccGLdRn8yoETMEnhHXq8S9rsEts4J6ts1EIrfQLoNRJfXwR
        cnTKcMqxTzanS+rE9Z8EIsFSFEnI3NbykCPR7w==
X-Google-Smtp-Source: APXvYqxjkac0l1P0cWY5PT2ReC6IY4k+O7P1hS5EaMIPtTQtakIQ2dNkMmBaJ/TSwnxS/jNiPuUYVSlMYyJqzSxph0E=
X-Received: by 2002:ac8:444f:: with SMTP id m15mr4392234qtn.110.1570027462655;
 Wed, 02 Oct 2019 07:44:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190902130831.23057-1-mircea.caprioru@analog.com>
 <20190902130831.23057-4-mircea.caprioru@analog.com> <20190903172937.GA15494@bogus>
 <20190908112907.6d9b8370@archlinux>
In-Reply-To: <20190908112907.6d9b8370@archlinux>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 2 Oct 2019 09:44:09 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+08qOpx_jpfvEh3LKtU4Bb7nuAdPF3OfvUn4EwZPn4Uw@mail.gmail.com>
Message-ID: <CAL_Jsq+08qOpx_jpfvEh3LKtU4Bb7nuAdPF3OfvUn4EwZPn4Uw@mail.gmail.com>
Subject: Re: [PATCH V4 4/4] dt-bindings: iio: adc: ad7192: Add binding
 documentation for AD7192
To:     Jonathan Cameron <jic23@kernel.org>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Sep 8, 2019 at 5:29 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Tue, 3 Sep 2019 18:29:37 +0100
> Rob Herring <robh@kernel.org> wrote:
>
> > On Mon, 2 Sep 2019 16:08:31 +0300, Mircea Caprioru wrote:
> > > This patch add device tree binding documentation for AD7192 adc in YAML
> > > format.
> > >
> > > Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
> It seems that I messed up before and didn't actually revert the v3 patch.
>
> I'll roll a small fix patch to bring the tree inline with this and send out to the
> list.
>
> Sorry about this. One of many things that went wrong in that last pull request!

This still has dtc and schema errors:

 DTC     Documentation/devicetree/bindings/iio/adc/adi,ad7192.example.dt.yaml
Documentation/devicetree/bindings/iio/adc/adi,ad7192.example.dts:20.13-23:
Warning (reg_format): /example-0/spi0/adc@0:reg: property has invalid
length (4 bytes) (#address-cells == 2, #size-cells == 1)
Documentation/devicetree/bindings/iio/adc/adi,ad7192.example.dt.yaml:
Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/adc/adi,ad7192.example.dt.yaml:
Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/adc/adi,ad7192.example.dt.yaml:
Warning (spi_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/adc/adi,ad7192.example.dts:18.17-36.15:
Warning (avoid_default_addr_size): /example-0/spi0/adc@0: Relying on
default #address-cells value
Documentation/devicetree/bindings/iio/adc/adi,ad7192.example.dts:18.17-36.15:
Warning (avoid_default_addr_size): /example-0/spi0/adc@0: Relying on
default #size-cells value
  CHECK   Documentation/devicetree/bindings/iio/adc/adi,ad7192.example.dt.yaml
/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/iio/adc/adi,ad7192.example.dt.yaml:
adc@0: avdd-supply:0: 'avdd' was expected
/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/iio/adc/adi,ad7192.example.dt.yaml:
adc@0: dvdd-supply:0: 'dvdd' was expected
