Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54D852501F
	for <lists+linux-iio@lfdr.de>; Tue, 21 May 2019 15:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbfEUN06 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 May 2019 09:26:58 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36239 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbfEUN06 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 May 2019 09:26:58 -0400
Received: by mail-wm1-f65.google.com with SMTP id j187so2905167wmj.1;
        Tue, 21 May 2019 06:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qrp/cCOlFJCvzIc4gQMAUxLU+7cAYh9D4Zth3uCG30U=;
        b=BGix0mkl0u5OQfGkGTujOD8MfOHzU4MYEmrQ2i+91eBnAXKE0bhRFBSfYaAgzMeOlI
         9ONIZrQ/YPo+0QNPpjlrSCzqMAu8ynnOKpefspeJHrh6Kwk5hL9ph5wXS5wa/qQDnTft
         MaN4qXXsIdqL4HSiXkY8mE675oJIwjj9wSW6YJVX0I6xQK0+EUkbRkLADENVvpD0T3bl
         nNhivqvhlkH+3twPkmVCNr/OaW4yC6DO/ChzmVK3xovROhCMNbqwQx48r54i+bWgDk3U
         lAmQd727iyPDH+t/wg8/fepVOzlr54pQ6k3rScOMSLLO1LYYT7ETgWGWtCqyKwfKcya9
         ikWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qrp/cCOlFJCvzIc4gQMAUxLU+7cAYh9D4Zth3uCG30U=;
        b=eoHPfnM/ddBqK/QpGyxRh1RzHzXwquMTRgn4rPlISO3bHPgVdqoWvo4lhEzKlDMfV5
         en7lv91SVEC+ZiOPlPPz9EEfTgZeIiOIW+q7GKHhNaEYrMcAobzkTdrFdRKG9x04yuJu
         Zl8kZexzFz3YFfiAcvWySL6Uh0Esil6FuwxKkOGZAJ66CRySyozfSGWOKbIghf6JoNyS
         0y6WMjl5OTqC52jzCMoAcHxv9smwqx4fdGKQni35un2QasbmMO8q/GUuC0cmVMEf9KY5
         SE4YAIzDZgJnrnqZTT5Eex5U+jWVJyWkBsH5NPCbab7XCyd7TU1v8eWJebaPSVH2zvhs
         q/0A==
X-Gm-Message-State: APjAAAWh+cb4dg2bUKsjzljBrW/sJqqN7eezxPvKAmexsJkzglSpDloi
        EY7L5k3poQDTCvVNIgS539ReJ/vWdPD+NSj3pKM=
X-Google-Smtp-Source: APXvYqzvGLXTpCYDjBTmFlxpnFdDs/GZX8wN3Yik3u04wGLJ1U4Jbdm4OYibVzfWSGgFLb4l674d8SHtW41xH+KCxlk=
X-Received: by 2002:a1c:e443:: with SMTP id b64mr3433813wmh.71.1558445216111;
 Tue, 21 May 2019 06:26:56 -0700 (PDT)
MIME-Version: 1.0
References: <1555943870-15353-1-git-send-email-manish.narani@xilinx.com> <1555943870-15353-4-git-send-email-manish.narani@xilinx.com>
In-Reply-To: <1555943870-15353-4-git-send-email-manish.narani@xilinx.com>
From:   Paul Thomas <pthomas8589@gmail.com>
Date:   Tue, 21 May 2019 09:26:44 -0400
Message-ID: <CAD56B7dw4kTRuXeKXyT6KbEP9E=B=KqpamL14d96LjGgAfrbGQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] arm64: zynqmp: DT: Add Xilinx AMS node
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        michal.simek@xilinx.com, Jisheng.Zhang@synaptics.com,
        olof@lixom.net, dinguyen@kernel.org, amit.kucheria@linaro.org,
        stefan.popa@analog.com, dmurphy@ti.com, marcus.folkesson@gmail.com,
        tmaimon77@gmail.com, ricardo@ribalda.com, xc-racer2@live.ca,
        contact@artur-rojek.eu, geert@linux-m68k.org,
        smohanad@codeaurora.org, charles-antoine.couret@essensium.com,
        stefan@agner.ch, max.krummenacher@toradex.com,
        lee.jones@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Manish,

Thank you for posting this! It is very much needed in the mainline
kernel, nice work.

On Mon, Apr 22, 2019 at 10:54 AM Manish Narani <manish.narani@xilinx.com> wrote:
>
> The Xilinx AMS includes an ADC as well as on-chip sensors that can be
> used to sample external and monitor on-die operating conditions, such as
> temperature and supply voltage levels.
>
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index 9aa6734..f776913 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -625,5 +625,31 @@
>                         reg = <0x0 0xfd4d0000 0x0 0x1000>;
>                         timeout-sec = <10>;
>                 };
> +
> +               xilinx_ams: ams@ffa50000 {
> +                       compatible = "xlnx,zynqmp-ams";
> +                       status = "disabled";
> +                       interrupt-parent = <&gic>;
> +                       interrupts = <0 56 4>;
> +                       interrupt-names = "ams-irq";
> +                       reg = <0x0 0xffa50000 0x0 0x800>;
> +                       reg-names = "ams-base";
> +                       #address-cells = <1>;
> +                       #size-cells = <1>;
> +                       #io-channel-cells = <1>;
> +                       ranges = <0 0 0xffa50800 0x800>;
> +
> +                       ams_ps: ams-ps@0,0 {
> +                               compatible = "xlnx,zynqmp-ams-ps";
> +                               status = "disabled";
> +                               reg = <0 0x400>;
> +                       };
> +
> +                       ams_pl: ams-pl@1,0 {
> +                               compatible = "xlnx,zynqmp-ams-pl";
> +                               status = "disabled";
> +                               reg = <0x400 0x400>;
> +                       };
> +               };
>         };
>  };
> --
> 2.1.1
>
I tested this with an older 4.18 kernel, and with a slightly different
devicetree (shown below) it seems to be working.

        xilinx_ams: ams@ffa50000 {
                compatible = "xlnx,zynqmp-ams";
                status = "okay";
                interrupt-parent = <&gic>;
                interrupts = <0 56 4>;
                interrupt-names = "ams-irq";
                reg = <0x0 0xffa50000 0x0 0x800>;
                reg-names = "ams-base";

                #address-cells = <2>;
                #size-cells = <2>;
                ranges;

                ams_ps: ams_ps@ffa50800 {
                        compatible = "xlnx,zynqmp-ams-ps";
                        reg = <0x0 0xffa50800 0x0 0x400>;
                };

                ams_pl: ams_pl@ffa50c00 {
                        compatible = "xlnx,zynqmp-ams-pl";
                        reg = <0x0 0xffa50c00 0x0 0x400>;
                };

Also I needed to have the clock defined "clocks = <&clk 70>;".

For the temperatures I get in_temp0_raw, in_temp1_raw and in_temp2 do
these correspond to channels 7,8 & 21 in the devicetree documentation?

thanks,
Paul
