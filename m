Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9EA25ED88
	for <lists+linux-iio@lfdr.de>; Sun,  6 Sep 2020 12:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbgIFKAR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Sep 2020 06:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgIFKAQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Sep 2020 06:00:16 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C637C061573;
        Sun,  6 Sep 2020 03:00:15 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id c8so9856216edv.5;
        Sun, 06 Sep 2020 03:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aGhpaDch/qma+IscrRl0cYZy7lpj0cr2oHNjS2QePxA=;
        b=B4pSN5nz9w/qQRbzqI+mxsCgLxkBXud+N3g2SdoT0wsMuPfhUcvAMqVuLhjvSn2fGo
         HzH2o6gsBwmLIyidGs0kRFNEwY4FBBl4AlVNhuNxnV8KdZSfuBEBw+wBwzHBdvS06VYo
         2ZomElQ5PNogwJzjaNevFIO8uWjsEcsRrnMMdcUw87JhVb/FvhU7w0I1XeBEYW0LF0kc
         93m6Is6Flkc+ssvMYz8o8T6LJYel1hjS9fA0tzy+j+FFnghefTSdmkUs82ruxFSKo0m/
         fu9qDsp3G1VOz3389sDBnzrd4ZgjAECIwIYAf8VloOWMu+BJPo7UYVf6Wl2hieYSUeOy
         GaCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aGhpaDch/qma+IscrRl0cYZy7lpj0cr2oHNjS2QePxA=;
        b=Q4BIVeC6oazsjpqgVQH2QsxkozNnxKelDMC+efQPbdv4bdd33vl9+HS3AKeG2sS64Q
         6WhyUKQ7kZZpzF8pKiZEqHEtARGXZqJt6IDKtntfu0wRbEBA5+Sel2vjNDHM6RuPnob2
         hRLs1TziGNzfrx2QfAgZzM30HHTAk5Nx0+FxIEFzzRnjcziLfhc3TJZjYVHMgl+X6J6D
         C81oFckF6OkVmCZQeAYHlB4tVVvsLJDtu01hwat5a86H0l/QMZOY9I0FLwEJpmFUk2aK
         qeQEvUXs2V5L/Gi1ql0ljscAMYDW/Et8GmKitEocFumt7vO8Ix10OdWQ6ljjSh4+6SFe
         3qOA==
X-Gm-Message-State: AOAM531ehVWAq9GRTiZkdDz+S3P4a2t+LS00FDkhZpOflPg8h9Oflj49
        humtk6lGTR0VFcDSpMHPDIqSaOw9YjK7+Hc1SHM=
X-Google-Smtp-Source: ABdhPJxAqxFQyE1Kl+4mODi9vPO6POjLyVlunsKBxaJ8PqTKqv8hUjgoBgGQVqGcl1QGFIt/cfZa6kgOF72qVeTg6Uw=
X-Received: by 2002:a50:9e6b:: with SMTP id z98mr16168513ede.365.1599386413694;
 Sun, 06 Sep 2020 03:00:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200905173004.216081-1-jic23@kernel.org> <20200905173004.216081-19-jic23@kernel.org>
In-Reply-To: <20200905173004.216081-19-jic23@kernel.org>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 6 Sep 2020 12:00:02 +0200
Message-ID: <CAFBinCD9BqANmYKSCaHf8U3r9RMtGCFCu4_afNo4T8WJnpMkUA@mail.gmail.com>
Subject: Re: [PATCH 18/20] dt-bindings:iio:adc:amlogic,meson-saradc yaml conversion
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Content-Type: multipart/mixed; boundary="0000000000000c1fd905aea22b79"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

--0000000000000c1fd905aea22b79
Content-Type: text/plain; charset="UTF-8"

Hi Jonathan,

On Sat, Sep 5, 2020 at 7:32 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> This binding is non trivial due to the range of different parts
> supported having several subtle quirks.
thank you for working on this!

> I am far from sure I have these correct. For example:
> 1) Can we have the clock adc_sel without adc_clk?
adc_sel and adc_clk only exist on GXBB and newer
Meson8, Meson8b and Meson8m2 have these clocks built into the SAR ADC IP block

> 2) I haven't restricted the amlogic,hhi-sysctrl to only
>    be present on the relevant parts if nvmem stuff also is, but
>    it would seem to be rather odd if it were otherwise.
yes, I think we can restrict this later

[...]
> +        adc@9680 {
> +            compatible = "amlogic,meson8b-saradc", "amlogic,meson-saradc";
> +            #io-channel-cells = <1>;
> +            reg = <0x0 0x9680 0x0 0x34>;
> +            interrupts = <GIC_SPI 73 IRQ_TYPE_EDGE_RISING>;
> +            clocks = <&xtal>,
> +                <&clkc CLKID_SAR_ADC>,
> +                <&clkc CLKID_SAR_ADC_CLK>,
> +                <&clkc CLKID_SAR_ADC_SEL>;
> +            clock-names = "clkin", "core";
CLKID_SAR_ADC_CLK and CLKID_SAR_ADC_SEL should not be in this Meson8b example

I have attached a patch for this as well as for making the clock
selection more restrictive (to catch errors like this). feel free to
include it in your patch if you think that it improves things


Best regards,
Martin

--0000000000000c1fd905aea22b79
Content-Type: text/x-patch; charset="US-ASCII"; name="meson-saradc-bindings-update.patch"
Content-Disposition: attachment; 
	filename="meson-saradc-bindings-update.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_keqxbr3b0>
X-Attachment-Id: f_keqxbr3b0

ZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vYWRjL2Ft
bG9naWMsbWVzb24tc2FyYWRjLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvaWlvL2FkYy9hbWxvZ2ljLG1lc29uLXNhcmFkYy55YW1sCmluZGV4IDViMmUwNzgyOGMzZC4u
NmQ5NGJmNzY5MDBlIDEwMDY0NAotLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvaWlvL2FkYy9hbWxvZ2ljLG1lc29uLXNhcmFkYy55YW1sCisrKyBiL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vYWRjL2FtbG9naWMsbWVzb24tc2FyYWRjLnlhbWwKQEAg
LTM1LDE4ICszNSw5IEBAIHByb3BlcnRpZXM6CiAgICAgZGVzY3JpcHRpb246IEludGVycnVwdCBp
bmRpY2F0ZXMgZW5kIG9mIHNhbXBsaW5nLgogICAgIG1heEl0ZW1zOiAxCiAKLSAgY2xvY2tzOgot
ICAgIG1pbkl0ZW1zOiAyCi0gICAgbWF4SXRlbXM6IDQKLQotICBjbG9jay1uYW1lczoKLSAgICBp
dGVtczoKLSAgICAgIC0gY29uc3Q6IGNsa2luCi0gICAgICAtIGNvbnN0OiBjb3JlCi0gICAgICAt
IGNvbnN0OiBhZGNfY2xrCi0gICAgICAtIGNvbnN0OiBhZGNfc2VsCi0gICAgbWluSXRlbXM6IDIK
LSAgICBtYXhJdGVtczogNAorICBjbG9ja3M6IHRydWUKKworICBjbG9jay1uYW1lczogdHJ1ZQog
CiAgIHZyZWYtc3VwcGx5OiB0cnVlCiAKQEAgLTc5LDEwICs3MCwyNiBAQCBhbGxPZjoKICAgICAg
IHByb3BlcnRpZXM6CiAgICAgICAgIG52bWVtLWNlbGxzOiB0cnVlCiAgICAgICAgIG52bWVtLWNl
bGwtbmFtZXM6IHRydWUKKyAgICAgICAgY2xvY2stbmFtZXM6CisgICAgICAgICAgaXRlbXM6Cisg
ICAgICAgICAgICAtIGNvbnN0OiBjbGtpbgorICAgICAgICAgICAgLSBjb25zdDogY29yZQorICAg
ICAgICAgIG1pbkl0ZW1zOiAyCisgICAgICAgIGNsb2NrczoKKyAgICAgICAgICBtaW5JdGVtczog
MgogICAgIGVsc2U6CiAgICAgICBwcm9wZXJ0aWVzOgogICAgICAgICBudm1lbS1jZWxsczogZmFs
c2UKICAgICAgICAgbXZtZW0tY2VsLW5hbWVzOiBmYWxzZQorICAgICAgICBjbG9jay1uYW1lczoK
KyAgICAgICAgICBpdGVtczoKKyAgICAgICAgICAgIC0gY29uc3Q6IGNsa2luCisgICAgICAgICAg
ICAtIGNvbnN0OiBjb3JlCisgICAgICAgICAgICAtIGNvbnN0OiBhZGNfY2xrCisgICAgICAgICAg
ICAtIGNvbnN0OiBhZGNfc2VsCisgICAgICAgICAgbWluSXRlbXM6IDQKKyAgICAgICAgY2xvY2tz
OgorICAgICAgICAgIG1pbkl0ZW1zOiA0CiAKICAgLSBpZjoKICAgICAgIHByb3BlcnRpZXM6CkBA
IC0xMzIsMTAgKzEzOSw3IEBAIGV4YW1wbGVzOgogICAgICAgICAgICAgI2lvLWNoYW5uZWwtY2Vs
bHMgPSA8MT47CiAgICAgICAgICAgICByZWcgPSA8MHgwIDB4OTY4MCAweDAgMHgzND47CiAgICAg
ICAgICAgICBpbnRlcnJ1cHRzID0gPEdJQ19TUEkgNzMgSVJRX1RZUEVfRURHRV9SSVNJTkc+Owot
ICAgICAgICAgICAgY2xvY2tzID0gPCZ4dGFsPiwKLSAgICAgICAgICAgICAgICA8JmNsa2MgQ0xL
SURfU0FSX0FEQz4sCi0gICAgICAgICAgICAgICAgPCZjbGtjIENMS0lEX1NBUl9BRENfQ0xLPiwK
LSAgICAgICAgICAgICAgICA8JmNsa2MgQ0xLSURfU0FSX0FEQ19TRUw+OworICAgICAgICAgICAg
Y2xvY2tzID0gPCZ4dGFsPiwgPCZjbGtjIENMS0lEX1NBUl9BREM+OwogICAgICAgICAgICAgY2xv
Y2stbmFtZXMgPSAiY2xraW4iLCAiY29yZSI7CiAgICAgICAgICAgICBudm1lbS1jZWxscyA9IDwm
dHNlbnNfY2FsZGF0YT47CiAgICAgICAgICAgICBudm1lbS1jZWxsLW5hbWVzID0gInRlbXBlcmF0
dXJlX2NhbGliIjsK
--0000000000000c1fd905aea22b79--
