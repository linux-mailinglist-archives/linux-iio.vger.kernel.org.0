Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1735154F683
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jun 2022 13:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236286AbiFQLQE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Jun 2022 07:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236254AbiFQLQD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Jun 2022 07:16:03 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5033396A4;
        Fri, 17 Jun 2022 04:16:01 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id r5so4201570iod.5;
        Fri, 17 Jun 2022 04:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=t/crlnZbBJQszYNcH9+aCU70dM7HBkp9N2s5QyPNLUk=;
        b=KjYSoJjQbHSzBiIh2OvctpgUON2u4IbMNHkuAcnrPX5S/8O+2ZqVL+M1OTWti1TgGE
         U3a+c0waowlN8KRIlHNwYNlX5PWBWecrqUFBF2t3EinouRe/3mJ3rUJmCVzpd4yKgyB7
         XAQjJrF5yzz/4IN635jYJA6DDgneEYjQIzB19Mv89dJJg1k3jF0EPSbZbfZy8eD5BmJv
         umqzL5gXktsRNmAiumwyLQQIsRbOm0kcPe2HywZwOMl/bFqj4uo9yMOhxmtIYtFNnKfx
         7kpkppI8wiEpDGOFh8+AmBeXhAgGr/cVeZamCja94WfRWTAgXgfTFpQckCHWWnOziQwd
         aSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=t/crlnZbBJQszYNcH9+aCU70dM7HBkp9N2s5QyPNLUk=;
        b=TyvS4Hg5PaPKIeL+IPDHhrLjZ1QpCeAgSHQyRPf/Te+nnXYV0t9tpzqCMiw6Hrj+L+
         /0DArzInyJpZnR4IirXK7KOVxVSgk989AcW+ficZwlAlKMuxfpuQnzs+gGz9jlnlGcFp
         60Bz/0J+NmRA1fXdXyAHtbuuAL1rlzzHIbczN1TEIXgKOQqoYgZG5NmOyv6kjJpOiL1T
         W1FA0EjfI8TDX6LPfXcRQCjCZyd0xq2BaytQUPLNi3PRVb0vqhAiqP6Yq/0L7iDVp9yS
         OSAU1XgwlgLlIg1BNmg/Ut4lWnlTcTpeP5Ge2p0EzWPyE7BLnyZFq3cMDak8+Kz1AWuu
         +PkA==
X-Gm-Message-State: AJIora8JdPKjZKanrsTptkI7uuM+GRRnOS41VGX3ho7FUITmWczyzSXD
        rGzVDsDUlvHflZKJH91paogNLRJiluimSJPGCuk=
X-Google-Smtp-Source: AGRyM1tFKZjYJUHdgUMGn9EB6+U2f/oxJq7gDzAwy6h/11fXVSFDBb4uXbC7kjFkRKwg/y/yQilyfk1BrMK1DcJRUUI=
X-Received: by 2002:a5d:9d8d:0:b0:669:cd5e:f953 with SMTP id
 ay13-20020a5d9d8d000000b00669cd5ef953mr4655343iob.153.1655464561141; Fri, 17
 Jun 2022 04:16:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220613111146.25221-1-peterwu.pub@gmail.com> <20220613111146.25221-7-peterwu.pub@gmail.com>
 <1655127197.567546.3564136.nullmailer@robh.at.kernel.org>
In-Reply-To: <1655127197.567546.3564136.nullmailer@robh.at.kernel.org>
From:   ChiaEn Wu <peterwu.pub@gmail.com>
Date:   Fri, 17 Jun 2022 19:15:49 +0800
Message-ID: <CABtFH5JPu5tOg4wGJf5ay1-NJHLcPTK4XxADGTksHW1-6wjMRQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/15] dt-bindings: mfd: Add Mediatek MT6370
To:     Rob Herring <robh@kernel.org>
Cc:     pavel@ucw.cz, robh+dt@kernel.org, linux-pm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-mediatek@lists.infradead.org, szunichen@gmail.com,
        lars@metafoo.de, matthias.bgg@gmail.com,
        Daniel Thompson <daniel.thompson@linaro.org>,
        lee.jones@linaro.org, ChiYuan Huang <cy_huang@richtek.com>,
        linux-leds@vger.kernel.org, linux-fbdev@vger.kernel.org,
        jingoohan1@gmail.com, devicetree@vger.kernel.org, jic23@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Rob,

Rob Herring <robh@kernel.org> =E6=96=BC 2022=E5=B9=B46=E6=9C=8813=E6=97=A5 =
=E9=80=B1=E4=B8=80 =E6=99=9A=E4=B8=8A9:33=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Mon, 13 Jun 2022 19:11:37 +0800, ChiaEn Wu wrote:
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >
> > Add Mediatek MT6370 binding documentation.
> >
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > ---
> >  .../bindings/mfd/mediatek,mt6370.yaml         | 279 ++++++++++++++++++
> >  .../dt-bindings/iio/adc/mediatek,mt6370_adc.h |  18 ++
> >  2 files changed, 297 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,mt63=
70.yaml
> >  create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6370_adc.h
> >
>
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> ./Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml: Unable to f=
ind schema file matching $id: http://devicetree.org/schemas/leds/backlight/=
mediatek,mt6370-backlight.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/=
mediatek,mt6370.example.dtb: pmic@34: backlight: False schema does not allo=
w {'compatible': ['mediatek,mt6370-backlight'], 'mediatek,bled-channel-use'=
: b'\x0f'}
>         From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/mfd/mediatek,mt6370.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/=
mediatek,mt6370.example.dtb: pmic@34: charger: False schema does not allow =
{'compatible': ['mediatek,mt6370-charger'], 'interrupts': [[48], [68], [6]]=
, 'interrupt-names': ['attach_i', 'uvp_d_evt', 'mivr'], 'io-channels': [[1,=
 5]], 'usb-otg-vbus-regulator': {'regulator-name': ['mt6370-usb-otg-vbus'],=
 'regulator-min-microvolt': [[4350000]], 'regulator-max-microvolt': [[58000=
00]], 'regulator-min-microamp': [[500000]], 'regulator-max-microamp': [[300=
0000]], 'phandle': [[2]]}}
>         From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/mfd/mediatek,mt6370.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/=
mediatek,mt6370.example.dtb: pmic@34: tcpc: False schema does not allow {'c=
ompatible': ['mediatek,mt6370-tcpc'], 'interrupts-extended': [[4294967295, =
4, 8]], 'connector': {'compatible': ['usb-c-connector'], 'label': ['USB-C']=
, 'vbus-supply': [[2]], 'data-role': ['dual'], 'power-role': ['dual'], 'try=
-power-role': ['sink'], 'source-pdos': [[570527844]], 'sink-pdos': [[570527=
944]], 'op-sink-microwatt': [[10000000]], 'ports': {'#address-cells': [[1]]=
, '#size-cells': [[0]], 'port@0': {'reg': [[0]], 'endpoint': {'remote-endpo=
int': [[4294967295]]}}, 'port@1': {'reg': [[1]], 'endpoint': {'remote-endpo=
int': [[4294967295]]}}, 'port@2': {'reg': [[2]], 'endpoint': {'remote-endpo=
int': [[4294967295]]}}}}}
>         From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/mfd/mediatek,mt6370.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/=
mediatek,mt6370.example.dtb: pmic@34: indicator: False schema does not allo=
w {'compatible': ['mediatek,mt6370-indicator'], '#address-cells': [[1]], '#=
size-cells': [[0]], 'multi-led@0': {'reg': [[0]], 'function': ['indicator']=
, 'color': [[9]], 'led-max-microamp': [[24000]], '#address-cells': [[1]], '=
#size-cells': [[0]], 'led@0': {'reg': [[0]], 'color': [[1]]}, 'led@1': {'re=
g': [[1]], 'color': [[2]]}, 'led@2': {'reg': [[2]], 'color': [[3]]}}, 'led@=
3': {'reg': [[3]], 'function': ['indicator'], 'color': [[0]], 'led-max-micr=
oamp': [[6000]]}}
>         From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/mfd/mediatek,mt6370.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/=
mediatek,mt6370.example.dtb: pmic@34: flashlight: False schema does not all=
ow {'compatible': ['mediatek,mt6370-flashlight'], '#address-cells': [[1]], =
'#size-cells': [[0]], 'led@0': {'reg': [[0]], 'led-sources': [[0]], 'functi=
on': ['flash'], 'color': [[0]], 'function-enumerator': [[1]], 'led-max-micr=
oamp': [[200000]], 'flash-max-microamp': [[500000]], 'flash-max-timeout-us'=
: [[1248000]]}, 'led@1': {'reg': [[1]], 'led-sources': [[1]], 'function': [=
'flash'], 'color': [[0]], 'function-enumerator': [[2]], 'led-max-microamp':=
 [[200000]], 'flash-max-microamp': [[500000]], 'flash-max-timeout-us': [[12=
48000]]}}
>         From schema: /builds/robherring/linux-dt-review/Documentation/dev=
icetree/bindings/mfd/mediatek,mt6370.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/=
mediatek,mt6370.example.dtb: backlight: mediatek,bled-channel-use: b'\x0f' =
is not of type 'object', 'array', 'boolean', 'null'
>         From schema: /usr/local/lib/python3.10/dist-packages/dtschema/sch=
emas/dt-core.yaml
> Documentation/devicetree/bindings/mfd/mediatek,mt6370.example.dtb:0:0: /e=
xample-0/i2c/pmic@34/backlight: failed to match any schema with compatible:=
 ['mediatek,mt6370-backlight']
> Documentation/devicetree/bindings/mfd/mediatek,mt6370.example.dtb:0:0: /e=
xample-0/i2c/pmic@34/charger: failed to match any schema with compatible: [=
'mediatek,mt6370-charger']
> Documentation/devicetree/bindings/mfd/mediatek,mt6370.example.dtb:0:0: /e=
xample-0/i2c/pmic@34/indicator: failed to match any schema with compatible:=
 ['mediatek,mt6370-indicator']
> Documentation/devicetree/bindings/mfd/mediatek,mt6370.example.dtb:0:0: /e=
xample-0/i2c/pmic@34/flashlight: failed to match any schema with compatible=
: ['mediatek,mt6370-flashlight']
> Documentation/devicetree/bindings/mfd/mediatek,mt6370.example.dtb:0:0: /e=
xample-0/i2c/pmic@34/tcpc: failed to match any schema with compatible: ['me=
diatek,mt6370-tcpc']
>

Before we submitted these patches, we had already checked by running
this command below,
"make DT_CHECKER_FLAGS=3D-m dt_binding_check
DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings/mfd/mediatek,mt6370.yam=
l".
But we could not find any errors like your error msg after the checking pro=
cess.

Our mfd dt-binding patch is dependent on "backlight dt-binding",
"charger dt-binding", "tcpc dt-binding", "indicator dt-binding" and
"flashlight dt-binding" patches.
Would you please apply them before you check mfd dt-binding patch?
Thank you so much!

> doc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/patch/
>
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit.
>

Best regards,
ChiaEn Wu
