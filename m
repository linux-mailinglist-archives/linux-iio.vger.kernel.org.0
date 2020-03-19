Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 815EC18BDB9
	for <lists+linux-iio@lfdr.de>; Thu, 19 Mar 2020 18:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbgCSRMz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Mar 2020 13:12:55 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46073 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727564AbgCSRMy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Mar 2020 13:12:54 -0400
Received: by mail-io1-f65.google.com with SMTP id e20so2644388ios.12;
        Thu, 19 Mar 2020 10:12:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yjdXxP3e2wpG/l7NWK6DuDmfBjGoZQM8YvboOq+g7g0=;
        b=q36m784BlzP+5dMUYG4Cvr07uB4e8mqQwMY1ZouKOGIg7m81jNtLlR5uL3LfCSaxW3
         o798OvXP9kMDAsjOztu1eHO2V+Br+yh+GHfsx0V6yAqRsKqVt0XXGshF55JwFSDOLWNS
         QKlj/8o6lu6y52K+XPag5CruPWaEQtGH64u6MFvXGBOLFTWr3qCGlZcExghp0kzraQea
         m3521P7vkgbN7AAEx0wdfF1l6/8WS3NEd23/O8Ef4ZNc+hdhbYpMs1sjhLc0ARFCeKH7
         +F1sDlDUw50PQOSVwiJZdRhMEq5MUuYi0hG/GIPSppxmZbuv19Q/M2niy8ffhPddAMmu
         ZAZg==
X-Gm-Message-State: ANhLgQ3UncpD063svQMmJge2xm2EOCTmM8TbT8xN0DLLdLFRT523KF9o
        LPy5U+D+OFma1ZqJP4WnJw==
X-Google-Smtp-Source: ADFU+vt/3mP0N3TAh9zjuCMufES4VN4ncBMPZcxaQCjBQ9DTKU7vUU/BzJycRBTeTbllCakvwTHedg==
X-Received: by 2002:a5d:9315:: with SMTP id l21mr3648105ion.122.1584637973687;
        Thu, 19 Mar 2020 10:12:53 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id d70sm1053550ill.57.2020.03.19.10.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 10:12:53 -0700 (PDT)
Received: (nullmailer pid 18786 invoked by uid 1000);
        Thu, 19 Mar 2020 17:12:52 -0000
Date:   Thu, 19 Mar 2020 11:12:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michael Auchter <michael.auchter@ni.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Auchter <michael.auchter@ni.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: iio: dac: ad5686: add binding
Message-ID: <20200319171252.GA18056@bogus>
References: <20200318153434.62833-1-michael.auchter@ni.com>
 <20200318153434.62833-3-michael.auchter@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318153434.62833-3-michael.auchter@ni.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 18 Mar 2020 10:34:34 -0500, Michael Auchter wrote:
> Add a binding for AD5686
> 
> Signed-off-by: Michael Auchter <michael.auchter@ni.com>
> ---
>  .../bindings/iio/dac/adi,ad5686.yaml          | 61 +++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml: $id: relative path/filename doesn't match actual path or filename
	expected: http://devicetree.org/schemas/iio/dac/adi,ad5686.yaml#

See https://patchwork.ozlabs.org/patch/1257638
Please check and re-submit.
