Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51EB02B524E
	for <lists+linux-iio@lfdr.de>; Mon, 16 Nov 2020 21:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732667AbgKPURb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Nov 2020 15:17:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:52408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729723AbgKPURb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 16 Nov 2020 15:17:31 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91D4C217A0;
        Mon, 16 Nov 2020 20:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605557849;
        bh=PdzmcNk2tX6XLrC2jIywbOEZY4vpD5QOz3SbZLToUvE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TYfsk9bsbMjVhAr5TDsQEPNqT0zxcn9j2E8LE01HSUBX/EPTLtz4AFQJTJ29OshIh
         lhN19v0cU2JzQeDYFL3bs85rbf4SpbnE27A4syh0Xwsq54jVXAvwYT4jERADS0qC9g
         gxGUPhivdqbOfGyeHbwhddaXqQdqfjuY5xQWnNxg=
Date:   Mon, 16 Nov 2020 20:17:25 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 00/29] dt-bindings:iio: Another set of yaml
 conversions.
Message-ID: <20201116201725.5591c8cf@archlinux>
In-Reply-To: <20201031134110.724233-1-jic23@kernel.org>
References: <20201031134110.724233-1-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 31 Oct 2020 13:40:41 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This set mostly consists of low hanging fruit along the way to converting
> all the existing IIO bindings.
> 
> @Rob, I've dropped your Reviewed-by for patch 16 because of the major
> change introducing checking on spi-cpol XOR spi-cpha.
> It works, but I'm not sure there isn't a more minimal way of doing it.
> 
> I could just have picked up the majority of these, but I forgot to
> cc the dt mailing list last time so want to resend them anyway.
Applied all but patch 16 where there are questions outstanding.

Thanks,

Jonathan

> 
> Changes since v1:
> * Updated various maintainers to reflect email bounces.
> * dht11 - added note on aosong as probably manufacturer
> * hoperf,hp03 - fixed description
> * ti,dac082s085
>   - Family typo
>   - Put back the reference regulator in example.
>   - Added checking of XOR of spi-cpha and spi-cpol
> * adi,ad7303 - drop adi,use-external-reference from example as no such thing.
> 
> Jonathan Cameron (29):
>   dt-bindings:iio:humidity:hdc100x Drop separate doc + add to
>     trivial-devices
>   dt-bindings:iio:humidity:htu21 Drop separate doc + add to
>     trivial-devices
>   dt-bindings:iio:humidity:st,hts221 yaml conversion.
>   dt-bindings:iio:humidity:dht11 yaml conversion
>   dt-bindings:iio:pressure:ms5637 Drop separate doc + add to
>     trivial-devices
>   dt-bindings:iio:pressure:murata,zpa2326 yaml conversion
>   dt-bindings:iio:pressure:meas,ms5611 yaml conversion.
>   dt-bindings:iio:pressure:hoperf,hp03 yaml conversion
>   dt-bindings:iio:proximity:semtech,sx9500 yaml conversion.
>   dt-bindings:iio:proximity:st,vl53l0x yaml conversion
>   dt-bindings:iio:proximity:ams,as3935 yaml conversion
>   dt-bindings:iio:dac:ti,dac5571 yaml conversion.
>   dt-bindings:iio:dac:ti,dac7311 yaml conversion
>   dt-bindings:iio:dac:ti,dac7512 yaml conversion
>   dt-bindings:iio:dac:ti,dac7612 yaml conversion
>   dt-bindings:iio:dac:ti,dac082s085 yaml conversion
>   dt-bindings:iio:dac:adi,ad7303 yaml conversion
>   dt-bindings:iio:dac:maxim,ds4424 yaml conversion
>   dt-bindings:iio:dac:fsl,vf610-dac yaml conversion
>   dt-bindings:iio:dac:microchip,mcp4725 yaml conversion
>   dt-bindings:iio:dac:maxim,max5821 yaml conversion
>   dt-bindings:iio:dac:nxp,lpc1850-dac yaml conversion.
>   dt-bindings:iio:dac:adi,ad5758 yaml conversion
>   dt-bindings:iio:temperature:melexis,mlx90614 yaml conversion
>   dt-bindings:iio:temperature:melexis,mlx90632 conversion to yaml
>   dt-bindings:iio:temperature:meas,tsys01 move to trivial-devices.yaml
>   dt-bindings:iio:temperature:maxim,max31856 yaml conversion.
>   dt-bindings:iio:temperature:maxim_thermocouple.txt to
>     maxim,max31855k.yaml
>   dt-bindings:iio:temperature:ti,tmp07 yaml conversion
> 
>  .../devicetree/bindings/iio/dac/ad5758.txt    |  83 -----------
>  .../devicetree/bindings/iio/dac/ad7303.txt    |  23 ----
>  .../bindings/iio/dac/adi,ad5758.yaml          | 129 ++++++++++++++++++
>  .../bindings/iio/dac/adi,ad7303.yaml          |  50 +++++++
>  .../devicetree/bindings/iio/dac/ds4424.txt    |  20 ---
>  .../bindings/iio/dac/fsl,vf610-dac.yaml       |  55 ++++++++
>  .../bindings/iio/dac/lpc1850-dac.txt          |  19 ---
>  .../devicetree/bindings/iio/dac/max5821.txt   |  14 --
>  .../bindings/iio/dac/maxim,ds4424.yaml        |  45 ++++++
>  .../bindings/iio/dac/maxim,max5821.yaml       |  44 ++++++
>  .../devicetree/bindings/iio/dac/mcp4725.txt   |  35 -----
>  .../bindings/iio/dac/microchip,mcp4725.yaml   |  71 ++++++++++
>  .../bindings/iio/dac/nxp,lpc1850-dac.yaml     |  58 ++++++++
>  .../bindings/iio/dac/ti,dac082s085.yaml       |  79 +++++++++++
>  .../bindings/iio/dac/ti,dac5571.txt           |  24 ----
>  .../bindings/iio/dac/ti,dac5571.yaml          |  52 +++++++
>  .../bindings/iio/dac/ti,dac7311.txt           |  23 ----
>  .../bindings/iio/dac/ti,dac7311.yaml          |  49 +++++++
>  .../bindings/iio/dac/ti,dac7512.txt           |  20 ---
>  .../bindings/iio/dac/ti,dac7512.yaml          |  42 ++++++
>  .../bindings/iio/dac/ti,dac7612.txt           |  28 ----
>  .../bindings/iio/dac/ti,dac7612.yaml          |  53 +++++++
>  .../bindings/iio/dac/ti-dac082s085.txt        |  34 -----
>  .../devicetree/bindings/iio/dac/vf610-dac.txt |  20 ---
>  .../bindings/iio/humidity/dht11.txt           |  14 --
>  .../bindings/iio/humidity/dht11.yaml          |  41 ++++++
>  .../bindings/iio/humidity/hdc100x.txt         |  17 ---
>  .../bindings/iio/humidity/hts221.txt          |  30 ----
>  .../bindings/iio/humidity/htu21.txt           |  13 --
>  .../bindings/iio/humidity/st,hts221.yaml      |  52 +++++++
>  .../bindings/iio/pressure/hoperf,hp03.yaml    |  47 +++++++
>  .../devicetree/bindings/iio/pressure/hp03.txt |  17 ---
>  .../bindings/iio/pressure/meas,ms5611.yaml    |  57 ++++++++
>  .../bindings/iio/pressure/ms5611.txt          |  19 ---
>  .../bindings/iio/pressure/ms5637.txt          |  17 ---
>  .../bindings/iio/pressure/murata,zpa2326.yaml |  62 +++++++++
>  .../bindings/iio/pressure/zpa2326.txt         |  29 ----
>  .../bindings/iio/proximity/ams,as3935.yaml    |  71 ++++++++++
>  .../bindings/iio/proximity/as3935.txt         |  34 -----
>  .../iio/proximity/semtech,sx9500.yaml         |  50 +++++++
>  .../bindings/iio/proximity/st,vl53l0x.yaml    |  42 ++++++
>  .../bindings/iio/proximity/sx9500.txt         |  23 ----
>  .../bindings/iio/proximity/vl53l0x.txt        |  18 ---
>  .../bindings/iio/temperature/max31856.txt     |  24 ----
>  .../iio/temperature/maxim,max31855k.yaml      |  76 +++++++++++
>  .../iio/temperature/maxim,max31856.yaml       |  54 ++++++++
>  .../iio/temperature/maxim_thermocouple.txt    |  24 ----
>  .../iio/temperature/melexis,mlx90614.yaml     |  50 +++++++
>  .../iio/temperature/melexis,mlx90632.yaml     |  55 ++++++++
>  .../bindings/iio/temperature/mlx90614.txt     |  24 ----
>  .../bindings/iio/temperature/mlx90632.txt     |  28 ----
>  .../bindings/iio/temperature/ti,tmp007.yaml   |  57 ++++++++
>  .../bindings/iio/temperature/tmp007.txt       |  33 -----
>  .../bindings/iio/temperature/tsys01.txt       |  19 ---
>  .../devicetree/bindings/trivial-devices.yaml  |  24 ++++
>  55 files changed, 1465 insertions(+), 726 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/dac/ad5758.txt
>  delete mode 100644 Documentation/devicetree/bindings/iio/dac/ad7303.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5758.yaml
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad7303.yaml
>  delete mode 100644 Documentation/devicetree/bindings/iio/dac/ds4424.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/fsl,vf610-dac.yaml
>  delete mode 100644 Documentation/devicetree/bindings/iio/dac/lpc1850-dac.txt
>  delete mode 100644 Documentation/devicetree/bindings/iio/dac/max5821.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/maxim,max5821.yaml
>  delete mode 100644 Documentation/devicetree/bindings/iio/dac/mcp4725.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/microchip,mcp4725.yaml
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/nxp,lpc1850-dac.yaml
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/ti,dac082s085.yaml
>  delete mode 100644 Documentation/devicetree/bindings/iio/dac/ti,dac5571.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/ti,dac5571.yaml
>  delete mode 100644 Documentation/devicetree/bindings/iio/dac/ti,dac7311.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/ti,dac7311.yaml
>  delete mode 100644 Documentation/devicetree/bindings/iio/dac/ti,dac7512.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/ti,dac7512.yaml
>  delete mode 100644 Documentation/devicetree/bindings/iio/dac/ti,dac7612.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/ti,dac7612.yaml
>  delete mode 100644 Documentation/devicetree/bindings/iio/dac/ti-dac082s085.txt
>  delete mode 100644 Documentation/devicetree/bindings/iio/dac/vf610-dac.txt
>  delete mode 100644 Documentation/devicetree/bindings/iio/humidity/dht11.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/humidity/dht11.yaml
>  delete mode 100644 Documentation/devicetree/bindings/iio/humidity/hdc100x.txt
>  delete mode 100644 Documentation/devicetree/bindings/iio/humidity/hts221.txt
>  delete mode 100644 Documentation/devicetree/bindings/iio/humidity/htu21.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/humidity/st,hts221.yaml
>  create mode 100644 Documentation/devicetree/bindings/iio/pressure/hoperf,hp03.yaml
>  delete mode 100644 Documentation/devicetree/bindings/iio/pressure/hp03.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/pressure/meas,ms5611.yaml
>  delete mode 100644 Documentation/devicetree/bindings/iio/pressure/ms5611.txt
>  delete mode 100644 Documentation/devicetree/bindings/iio/pressure/ms5637.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/pressure/murata,zpa2326.yaml
>  delete mode 100644 Documentation/devicetree/bindings/iio/pressure/zpa2326.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/ams,as3935.yaml
>  delete mode 100644 Documentation/devicetree/bindings/iio/proximity/as3935.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/semtech,sx9500.yaml
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/st,vl53l0x.yaml
>  delete mode 100644 Documentation/devicetree/bindings/iio/proximity/sx9500.txt
>  delete mode 100644 Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
>  delete mode 100644 Documentation/devicetree/bindings/iio/temperature/max31856.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/maxim,max31855k.yaml
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/maxim,max31856.yaml
>  delete mode 100644 Documentation/devicetree/bindings/iio/temperature/maxim_thermocouple.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/melexis,mlx90614.yaml
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/melexis,mlx90632.yaml
>  delete mode 100644 Documentation/devicetree/bindings/iio/temperature/mlx90614.txt
>  delete mode 100644 Documentation/devicetree/bindings/iio/temperature/mlx90632.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/ti,tmp007.yaml
>  delete mode 100644 Documentation/devicetree/bindings/iio/temperature/tmp007.txt
>  delete mode 100644 Documentation/devicetree/bindings/iio/temperature/tsys01.txt
> 

