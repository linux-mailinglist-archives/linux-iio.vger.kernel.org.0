Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68CFC1D9793
	for <lists+linux-iio@lfdr.de>; Tue, 19 May 2020 15:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgESNXc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 May 2020 09:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbgESNXc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 May 2020 09:23:32 -0400
Received: from mo6-p01-ob.smtp.rzone.de (mo6-p01-ob.smtp.rzone.de [IPv6:2a01:238:20a:202:5301::9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C44C08C5C0;
        Tue, 19 May 2020 06:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1589894608;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=ICGCVm2uLS51x4Eyn+JU2NynH5F5RrXUuBeWf2MLNAs=;
        b=nnj0J0UfG5aTSOZx3SaksqiVAO8mbmMkp6aoQ2OC8Zw7zedAVga2ytZsJfxVIEEwLF
        nuiBvGur2VWmMXLzOMJ0JCL8dBZ2QpwlKCI7nELyjI13B8hWH7E7asF6XbmLYysH+mMx
        h9D1sIfQ/PLBQuWvoZ0ZkzSpZkaUxli6FcCA7KvzfvvQPGEhb47QUTKPXNC+EAOWpqZX
        SlzZDUwgXf15WPIbC5PjR3906cMddXGc987HCZv21M6pzvK02ZZnGb3p6bAb6omWlY4T
        KvzBZnQCCEleYD1OwiG9bIOFIQ7xEooSMrOdf1ucXWRSwObmnL3EaO8BrP9wRWyFdpXa
        11Ew==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8j9IczFaoo="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 46.6.2 DYNA|AUTH)
        with ESMTPSA id 60b02dw4JDMDl0g
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Tue, 19 May 2020 15:22:13 +0200 (CEST)
Date:   Tue, 19 May 2020 15:22:07 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jonathan Albrieux <jonathan.albrieux@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jilayne Lovejoy <opensource@jilayne.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Steve Winslow <swinslow@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 1/4] dt-bindings: iio: magnetometer: ak8975: convert
 txt format to yaml
Message-ID: <20200519132207.GA4623@gerhold.net>
References: <20200519124402.26076-1-jonathan.albrieux@gmail.com>
 <20200519124402.26076-2-jonathan.albrieux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519124402.26076-2-jonathan.albrieux@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, May 19, 2020 at 02:43:51PM +0200, Jonathan Albrieux wrote:
> Converts documentation from txt format to yaml.
> 
> Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
> ---
>  .../bindings/iio/magnetometer/ak8975.txt      | 30 ---------
>  .../bindings/iio/magnetometer/ak8975.yaml     | 66 +++++++++++++++++++
>  2 files changed, 66 insertions(+), 30 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/ak8975.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt b/Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt
> deleted file mode 100644
> index aa67ceb0d4e0..000000000000
> --- a/Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt
> +++ /dev/null
> @@ -1,30 +0,0 @@
> -* AsahiKASEI AK8975 magnetometer sensor
> -
> -Required properties:
> -
> -  - compatible : should be "asahi-kasei,ak8975"
> -  - reg : the I2C address of the magnetometer
> -
> -Optional properties:
> -
> -  - gpios : should be device tree identifier of the magnetometer DRDY pin
> -  - vdd-supply: an optional regulator that needs to be on to provide VDD
> -  - mount-matrix: an optional 3x3 mounting rotation matrix
> -
> -Example:
> -
> -ak8975@c {
> -        compatible = "asahi-kasei,ak8975";
> -        reg = <0x0c>;
> -        gpios = <&gpj0 7 0>;
> -        vdd-supply = <&ldo_3v3_gnss>;
> -        mount-matrix = "-0.984807753012208",  /* x0 */
> -                       "0",                   /* y0 */
> -                       "-0.173648177666930",  /* z0 */
> -                       "0",                   /* x1 */
> -                       "-1",                  /* y1 */
> -                       "0",                   /* z1 */
> -                       "-0.173648177666930",  /* x2 */
> -                       "0",                   /* y2 */
> -                       "0.984807753012208";   /* z2 */
> -};
> diff --git a/Documentation/devicetree/bindings/iio/magnetometer/ak8975.yaml b/Documentation/devicetree/bindings/iio/magnetometer/ak8975.yaml
> new file mode 100644
> index 000000000000..86e3efa693a8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/magnetometer/ak8975.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/magnetometer/ak8975.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AsahiKASEI AK8975 magnetometer sensor
> +
> +maintainers:
> +  - can't find a mantainer, author is Laxman Dewangan <ldewangan@nvidia.com>

Should probably add someone here, although I'm not sure who either.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - "asahi-kasei,ak8975"
> +      - "ak8975"
> +      - "asahi-kasei,ak8963"
> +      - "ak8963"
> +      - "asahi-kasei,ak09911"
> +      - "ak09911"
> +      - "asahi-kasei,ak09912"
> +      - "ak09912"
> +

I wonder if the ones without vendor prefix (asahi-kasei,) should be
marked as deprecated somehow?

Looking at some other schemas I see either a "# deprecated" comment, or:

properties:
  compatible:
    oneOf:
      - const: asahi-kasei,ak8975
      - const: asahi-kasei,ak8963
      - const: asahi-kasei,ak09911
      - const: asahi-kasei,ak09912
      - const: ak8975
        deprecated: true
      - const: ak8963
        deprecated: true
      - const: ak09911
        deprecated: true
      - const: ak09912
        deprecated: true

(e.g. in Documentation/devicetree/bindings/sound/samsung,odroid.yaml)
I guess this one is preferred since it allows parsing those
compatibles as deprecated?

> +  reg:
> +    maxItems: 1
> +    description: the I2C address of the magnetometer
> +
> +  gpios:
> +    description: should be device tree identifier of the magnetometer DRDY pin
> +
> +  vdd-supply:
> +    maxItems: 1
> +    description: |
> +      an optional regulator that needs to be on to provide VDD power to
> +      the sensor.
> +
> +  mount-matrix:
> +    description: an optional 3x3 mounting rotation matrix
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    i2c@78b7000 {
> +        reg = <0x78b6000 0x600>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        ak8975@c {

Per device tree specification this should preferably use a generic name
describing the function of the device, i.e. magnetometer@c.

> +            compatible = "asahi-kasei,ak8975";
> +            reg = <0x0c>;
> +            gpios = <&gpj0 7 0>;

I think using the dt-bindings constants for the GPIO flags is preferred
now, i.e. gpios = <&gpj0 7 GPIO_ACTIVE_HIGH>.

> +            vdd-supply = <&ldo_3v3_gnss>;
> +            mount-matrix = "-0.984807753012208",  /* x0 */
> +                           "0",                   /* y0 */
> +                           "-0.173648177666930",  /* z0 */
> +                           "0",                   /* x1 */
> +                           "-1",                  /* y1 */
> +                           "0",                   /* z1 */
> +                           "-0.173648177666930",  /* x2 */
> +                           "0",                   /* y2 */
> +                           "0.984807753012208";   /* z2 */
> +        };
> +    };
> -- 
> 2.17.1
