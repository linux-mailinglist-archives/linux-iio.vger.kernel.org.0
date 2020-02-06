Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90A3A153DD6
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2020 05:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbgBFEYd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 5 Feb 2020 23:24:33 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35309 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbgBFEYd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 Feb 2020 23:24:33 -0500
Received: by mail-pf1-f196.google.com with SMTP id y73so2384061pfg.2
        for <linux-iio@vger.kernel.org>; Wed, 05 Feb 2020 20:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=r/EB8vKdOIGyVfGGy6ndAk8y4CEDnzKKwajRB6fo/Ug=;
        b=d5i1wkGoQkBN525LDzVEZ0hZ3DF4hypWZWxm1A/fAHdx6Yjz4Pp12sPCvi0cvD6YyD
         i2BI57Hq8nrXcrgN1cwi2p1c1lruK315q9JpHznHXWUeZt8Xd93Manl205Bj2NmklVqk
         4fWlakzK2wmpDXvM4/ur/68mr3jWamNU/zHug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=r/EB8vKdOIGyVfGGy6ndAk8y4CEDnzKKwajRB6fo/Ug=;
        b=aQTx+bkCJ7ksCL+eREoblWeX5xz7j/Qy1wmnHN0a6945Tho6ztdb6ogxCQTAqU/WdI
         AwcRYDg6rv5bE42psPuPi8iU0yr2w4i77mqnG4bRPcvvWytW8ew8DED7PoGzw8I3tbIZ
         e0q1GiCJi2vfDMeyBu646bsF+hOpfsJjZegninH1p8xv7GiLV+hRCciYey8MFnJYKcUA
         HOGMOpYC7Zi4B33VG9km56JT45nRc87bf8yiHr0HWDRV5nCvah2+3h+uuPGzLhNONSKH
         rA8aLajRWO4mZNLIy2FPOZEc0qMX9ofIWznOI/Lf2YBqCLkP1W3CG3LbKoHT8X4xskFP
         X74g==
X-Gm-Message-State: APjAAAWYKAakZs7ZhfKWJucI8lucGbtkICAP2AXb1P2pv9fZ2qNzAi7c
        nTetCK8J6ijtgVFmHyqf4WgKsQ==
X-Google-Smtp-Source: APXvYqw5d4n+gmSHrGnvae8L9c3b94CQRh9KoCreL3P3Td4dguhV2Ah/+dFtVSjeCvz9jw7f3R0bPw==
X-Received: by 2002:a62:e30d:: with SMTP id g13mr1750129pfh.92.1580963071778;
        Wed, 05 Feb 2020 20:24:31 -0800 (PST)
Received: from [192.168.139.53] (50-196-3-218-static.hfc.comcastbusiness.net. [50.196.3.218])
        by smtp.gmail.com with ESMTPSA id r145sm1126382pfr.5.2020.02.05.20.24.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2020 20:24:31 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3 3/3] dt-bindings: iio: chemical: consolidate atlas-sensor docs
Date:   Wed, 5 Feb 2020 20:24:30 -0800
Message-Id: <214E66BE-6839-45DA-A676-103CC10FAF4A@konsulko.com>
References: <20200205164027.GA1992@bogus>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        devicetree@vger.kernel.org
In-Reply-To: <20200205164027.GA1992@bogus>
To:     Rob Herring <robh@kernel.org>
X-Mailer: iPhone Mail (17D50)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



> On Feb 5, 2020, at 08:40, Rob Herring <robh@kernel.org> wrote:
>=20
> =EF=BB=BFOn Wed,  5 Feb 2020 11:04:21 +0200, Matt Ranostay wrote:
>> Since Atlas Scientific device support only varies from the compatible
>> string is ideal all the respective docs are merged into a single doc
>> named atlas,sensor.yaml
>>=20
>> Cc: devicetree@vger.kernel.org
>> Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
>> ---
>> .../bindings/iio/chemical/atlas,ec-sm.txt     | 21 --------
>> .../bindings/iio/chemical/atlas,orp-sm.txt    | 21 --------
>> .../bindings/iio/chemical/atlas,ph-sm.txt     | 21 --------
>> .../bindings/iio/chemical/atlas,sensor.yaml   | 53 +++++++++++++++++++
>> 4 files changed, 53 insertions(+), 63 deletions(-)
>> delete mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,e=
c-sm.txt
>> delete mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,o=
rp-sm.txt
>> delete mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,p=
h-sm.txt
>> create mode 100644 Documentation/devicetree/bindings/iio/chemical/atlas,s=
ensor.yaml
>>=20
>=20
> My bot found errors running 'make dt_binding_check' on your patch:
>=20
> warning: no schema found in file: Documentation/devicetree/bindings/iio/ch=
emical/atlas,sensor.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/c=
hemical/atlas,sensor.yaml: ignoring, error in schema: $id
> Documentation/devicetree/bindings/display/simple-framebuffer.example.dts:2=
1.16-37.11: Warning (chosen_node_is_root): /example-0/chosen: chosen node mu=
st be at root node
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/c=
hemical/atlas,sensor.yaml: $id: 'http://devicetree.org/schemas/iio/chemical/=
atlas,sensor.yaml##' is not a 'uri-reference'
> Documentation/devicetree/bindings/Makefile:12: recipe for target 'Document=
ation/devicetree/bindings/iio/chemical/atlas,sensor.example.dts' failed
> make[1]: *** [Documentation/devicetree/bindings/iio/chemical/atlas,sensor.=
example.dts] Error 1
> Makefile:1263: recipe for target 'dt_binding_check' failed
> make: *** [dt_binding_check] Error 2
>=20
> See https://patchwork.ozlabs.org/patch/1233724
> Please check and re-submit.

Gah will do...=20

- Matt=
