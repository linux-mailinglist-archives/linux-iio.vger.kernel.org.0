Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93A3DCE9FF
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2019 19:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbfJGRAh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 7 Oct 2019 13:00:37 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:45603 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbfJGRAh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Oct 2019 13:00:37 -0400
Received: from localhost ([82.212.252.42]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MYLqs-1icsjf01h4-00VSnn; Mon, 07 Oct 2019 19:00:21 +0200
Date:   Mon, 7 Oct 2019 19:00:18 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] dt-bindings: iio: maxbotix,mb1232.yaml: transform to
 yaml
Message-ID: <20191007170018.673p6fs6mjokihn6@arbad>
References: <20191006142715.45k64cgw7mzlekm5@arbad>
 <CAL_Jsq+0SpRVmGJSm5Hw8bQ_zdeJy5wfTb9RM1r=crkiT2uM-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAL_Jsq+0SpRVmGJSm5Hw8bQ_zdeJy5wfTb9RM1r=crkiT2uM-Q@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:fBoQeayn92YRJEjgYIHYfQdyrqJFqK9E48AtQ7celFTOw3KBIAo
 GPSeMgYihf3sBmTCsf1YdWRaLdomESc1CxrOfU2kLOGXuqdQ/A6zx8efHbkzMhVcC8uHLKB
 rx9EttuwyIfEIZPlrMbKtUhqb06u3RX+wgj0gqyWP/PNBwHsbnTZVatjuIc43lNVL/nP2Ig
 PpwGLUiczXFVvHbQIQ2Wg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:lVHbNj68mDs=:z4Vj4C+6eecmzCJVRro6iQ
 zPsHoAAVbK6H/XYaZZCpm06rJyv93AcESF+KLN2c0m9I/MsJiD/XMNf7//6fCT+fbl5bpXLTv
 6bKi/JAHDOsOEiVATgzSKhjImll3vXVcg/t3WhD8xlXj5sud7FKzmIR+pPnlNlTY90sQR0hHX
 9WOaKU8eHZ2ZEWCuuuj8akyWfr5g/3y/K/i/EgDvdLjuFOFRMaQ8BQ6b7xbnjMTcLksXnPTL3
 dlr+tIP3qsZqTAFP4PB4w8XphWy07IhotB5iywlTS8GfCl8Ck0mh06Itfdva8Trk48swxLRRP
 pP3mBCTQcmTa6l5CjmJrnlvNToXb+15YesFyRGHd0MFkh2ImlkKeSIr7xjUA2OgdbjG27UGkv
 0E4a99yyhzk3j11RvpJcP4mJ0x/ajfZsyMDM1XLoSQ2wdPJQgi24NEb8jeibXOU04GiejyT8A
 KXBH7eGQ+jUIFJg09OM9xDUKpbaamkScM5/WurogxF6aWlVkYRX9OtTgSg+s8dm5uGIdd9UYs
 +OL2cfm94qlsKpkafnvLKd1n3B9ezJjWHbi/CXrsQ8ZvHIWsHiIixb/pwP+bjxbOzvhW27+2g
 p0BjTuGaqguPnNf5opf4JfOYWEiGfnpaQGgg0TUQ4JLDtSW2+jgHShEPbU0siAA1hQvGAdRrj
 LrkEsyOSUA51QiqQMpnVVnyKMN8U+KRm1QUaKb/ITY4LZd6eQzy3kaGy3RI0SYZAvyi1+/ovz
 bIoqyx20cKYAlR9YVMssQUHD7gLRssMf3e4q9cBLe5+yOjbXrp+OfA39C+FVmzSHPIKtLiR9Y
 llBr+8C57MZM4kvKeJR6OLtHyADW4gQssLzerTUN/CKLrPujC/Vf/7EG+XNE0Dn5IR81hDtRJ
 dMDPRzq/WCh3tAuIMe+w==
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Rob,

i don't get this error. Is there anything i'm doing wrong here?

ak@arbad:/project/opt-sw/linux-robh$ make O=../build-wega-robh/ dt_binding_check
make[1]: Verzeichnis „/project/opt-sw/build-wega-robh“ wird betreten
  SCHEMA  Documentation/devicetree/bindings/processed-schema.yaml
  /project/opt-sw/linux-robh/Documentation/devicetree/bindings/net/adi,adin.yaml:
  ignoring, error in schema 'adi,fifo-depth-bits'
  warning: no schema found in file:
  /project/opt-sw/linux-robh/Documentation/devicetree/bindings/net/adi,adin.yaml
  /project/opt-sw/linux-robh/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml:
  ignoring, error in schema '0'
  warning: no schema found in file:
  /project/opt-sw/linux-robh/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
    CHKDT   Documentation/devicetree/bindings/iio/proximity/maxbotix,mb1232.yaml
    CHKDT   [...]


But anyway i've fixed and send it out again.

Andreas



Rob Herring <robh+dt@kernel.org> schrieb am Mo, 07. Okt 07:42:
> On Sun, Oct 6, 2019 at 9:27 AM Andreas Klinger <ak@it-klinger.de> wrote:
> >
> > transform existing documentation of maxbotix,mb1232 ultrasonic ranger
> > from text documentation format into yaml.
> >
> > Changes in v2:
> > - removed description of reg property
> > - added a line:
> >   additionalProperties: false
> >
> > Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> > ---
> >  .../bindings/iio/proximity/maxbotix,mb1232.txt     | 29 -----------
> >  .../bindings/iio/proximity/maxbotix,mb1232.yaml    | 56 ++++++++++++++++++++++
> >  2 files changed, 56 insertions(+), 29 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/iio/proximity/maxbotix,mb1232.txt
> >  create mode 100644 Documentation/devicetree/bindings/iio/proximity/maxbotix,mb1232.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/iio/proximity/maxbotix,mb1232.txt b/Documentation/devicetree/bindings/iio/proximity/maxbotix,mb1232.txt
> > deleted file mode 100644
> > index dd1058fbe9c3..000000000000
> > --- a/Documentation/devicetree/bindings/iio/proximity/maxbotix,mb1232.txt
> > +++ /dev/null
> > @@ -1,29 +0,0 @@
> > -* MaxBotix I2CXL-MaxSonar ultrasonic distance sensor of type  mb1202,
> > -  mb1212, mb1222, mb1232, mb1242, mb7040 or mb7137 using the i2c interface
> > -  for ranging
> > -
> > -Required properties:
> > - - compatible:         "maxbotix,mb1202",
> > -                       "maxbotix,mb1212",
> > -                       "maxbotix,mb1222",
> > -                       "maxbotix,mb1232",
> > -                       "maxbotix,mb1242",
> > -                       "maxbotix,mb7040" or
> > -                       "maxbotix,mb7137"
> > -
> > - - reg:                        i2c address of the device, see also i2c/i2c.txt
> > -
> > -Optional properties:
> > - - interrupts:         Interrupt used to announce the preceding reading
> > -                       request has finished and that data is available.
> > -                       If no interrupt is specified the device driver
> > -                       falls back to wait a fixed amount of time until
> > -                       data can be retrieved.
> > -
> > -Example:
> > -proximity@70 {
> > -       compatible = "maxbotix,mb1232";
> > -       reg = <0x70>;
> > -       interrupt-parent = <&gpio2>;
> > -       interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
> > -};
> > diff --git a/Documentation/devicetree/bindings/iio/proximity/maxbotix,mb1232.yaml b/Documentation/devicetree/bindings/iio/proximity/maxbotix,mb1232.yaml
> > new file mode 100644
> > index 000000000000..e2fb1f6d4dbe
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/proximity/maxbotix,mb1232.yaml
> > @@ -0,0 +1,56 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/proximity/maxbotix,mb1232.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: MaxBotix I2CXL-MaxSonar ultrasonic distance sensor
> > +
> > +maintainers:
> > +  - Andreas Klinger <ak@it-klinger.de>
> > +
> > +description: |
> > +  MaxBotix I2CXL-MaxSonar ultrasonic distance sensor of type  mb1202,
> > +  mb1212, mb1222, mb1232, mb1242, mb7040 or mb7137 using the i2c interface
> > +  for ranging
> > +
> > +  Specifications about the devices can be found at:
> > +  https://www.maxbotix.com/documents/I2CXL-MaxSonar-EZ_Datasheet.pdf
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - maxbotix,mb1202
> > +      - maxbotix,mb1212
> > +      - maxbotix,mb1222
> > +      - maxbotix,mb1232
> > +      - maxbotix,mb1242
> > +      - maxbotix,mb7040
> > +      - maxbotix,mb7137
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    description:
> > +      Interrupt used to announce the preceding reading request has finished
> > +      and that data is available.  If no interrupt is specified the device
> > +      driver falls back to wait a fixed amount of time until data can be
> > +      retrieved.
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    proximity@70 {
> 
> Fails to build with 'make dt_binding_check':
> 
> Documentation/devicetree/bindings/iio/proximity/maxbotix,mb1232.example.dts:20.11-24:
> Warning (reg_format): /example-0/proximity@70:reg: property has
> invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
> Documentation/devicetree/bindings/iio/proximity/maxbotix,mb1232.example.dt.yaml:
> Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
> Documentation/devicetree/bindings/iio/proximity/maxbotix,mb1232.example.dt.yaml:
> Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
> Documentation/devicetree/bindings/iio/proximity/maxbotix,mb1232.example.dt.yaml:
> Warning (spi_bus_reg): Failed prerequisite 'reg_format'
> 
> You have to put this under an i2c bus node.
> 
> i2c {
>   #address-cells = <1>;
>   #size-cells = <0>;
>   ...
> };
> 
> > +      compatible = "maxbotix,mb1232";
> > +      reg = <0x70>;
> > +      interrupt-parent = <&gpio2>;
> > +      interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
> > +    };
> > --
> > 2.11.0

-- 
Andreas Klinger
Grabenreith 27
84508 Burgkirchen
+49 8623 919966
ak@it-klinger.de
www.it-klinger.de
www.grabenreith.de
