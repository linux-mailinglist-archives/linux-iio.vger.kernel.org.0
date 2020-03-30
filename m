Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6DD8197FC6
	for <lists+linux-iio@lfdr.de>; Mon, 30 Mar 2020 17:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbgC3Phr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Mar 2020 11:37:47 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:36455 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729059AbgC3Phr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Mar 2020 11:37:47 -0400
Received: by mail-il1-f193.google.com with SMTP id p13so16193635ilp.3;
        Mon, 30 Mar 2020 08:37:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mkwxb5JvjMmyFZrDRCuhIwp5i7N+YTkvrCmiuVH1Fic=;
        b=OG44WY7K6YPCEe3T/IcnhkGV25/psznkLeiKaEidX5Vovu22Y5cvf6RNM1IM9SsVZM
         fSgmTfopqJqo6D/TGgfo2PbH5nwaZxiTMuuQdr6lF/JS9ODtCXJv/42wQmJKpZxVKrJh
         pSxORQixh60vYEoqhc0Fie6m9ab2ItL5B5+UD+5XgNMlOyGSeuXxoOO3xRsiGYRqa8L/
         EVcJS44pv+D5zPpn+MiHVU9pakXqMSRgDmgaaRhnuMoU3dajc9/wxR5h6J53+TX82a85
         tZHJIzxROvWvjOkxheUkcr7yZDXFXEu0bD0Ul/qATaywHxdFOHNvzjVgmce+SlQrpZIm
         SdOQ==
X-Gm-Message-State: ANhLgQ1j96ZMrGxxdfJtlMmK7RZdJuU5hGF4hfh2Hrbujab6bnkt9oEU
        oOzgknQErPnzcD9NGHOKsA==
X-Google-Smtp-Source: ADFU+vt21JoipmYTiUdTolbv6zjigW1PlZnXRMPY/IpL+qcHi+xo9piY1XQqocbQl+43wrwQMa/9Ow==
X-Received: by 2002:a92:8953:: with SMTP id n80mr11430471ild.5.1585582666374;
        Mon, 30 Mar 2020 08:37:46 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id l17sm5041250ilf.28.2020.03.30.08.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 08:37:45 -0700 (PDT)
Received: (nullmailer pid 18293 invoked by uid 1000);
        Mon, 30 Mar 2020 15:37:43 -0000
Date:   Mon, 30 Mar 2020 09:37:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        jic23@kernel.org, linux-kernel@vger.kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        mark.rutland@arm.com, Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH v5 1/2] dt-bindings: iio: accel: Add bmi088 accelerometer
 bindings
Message-ID: <20200330153743.GA17787@bogus>
References: <20200324080309.12171-1-mike.looijmans@topic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324080309.12171-1-mike.looijmans@topic.nl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 24 Mar 2020 09:03:07 +0100, Mike Looijmans wrote:
> This adds the device-tree bindings for the Bosch Sensortec BMI088 IMU,
> the accelerometer part.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
> v2: convert to yaml format
> v3..v4: -
> v5: submit together with driver code as patch series
>  .../bindings/iio/accel/bosch,bmi088.yaml      | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml:  while scanning a simple key
  in "<unicode string>", line 32, column 3
could not find expected ':'
  in "<unicode string>", line 38, column 3
Documentation/devicetree/bindings/Makefile:12: recipe for target 'Documentation/devicetree/bindings/iio/accel/bosch,bmi088.example.dts' failed
make[1]: *** [Documentation/devicetree/bindings/iio/accel/bosch,bmi088.example.dts] Error 1
make[1]: *** Waiting for unfinished jobs....
warning: no schema found in file: Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.yaml: ignoring, error parsing file
Makefile:1262: recipe for target 'dt_binding_check' failed
make: *** [dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1260498

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.
