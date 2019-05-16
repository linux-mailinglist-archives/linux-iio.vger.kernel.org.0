Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E23AA208A1
	for <lists+linux-iio@lfdr.de>; Thu, 16 May 2019 15:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfEPNyM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 16 May 2019 09:54:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:37772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726692AbfEPNyL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 16 May 2019 09:54:11 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34FB620657;
        Thu, 16 May 2019 13:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558014851;
        bh=A3Fau94+VxO0YwvQOmsmkty73sbzskK8S5b1POdzZ+E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0tCcEjHxkdU3RCjZIbO7QIevuA0uOVmqtZ50BKCFX4kT124MVtaxdb90HIwbR3ux6
         0QZJHY91s93a2jHEoJ1Nf/haGxhHK2LY7ZJpvH5NZBjdndkm5WDxUMcMTm5FfW6edZ
         TjhF3V0y2Rd1OrZgXBLpW5LSLSoeVRnZhwkWFMF4=
Received: by mail-qt1-f177.google.com with SMTP id k24so3936630qtq.7;
        Thu, 16 May 2019 06:54:11 -0700 (PDT)
X-Gm-Message-State: APjAAAXEej0Msz97wqGiMusw1lKkGTle6sf5rlpmXqU3jMYGvO/2YD7j
        KmSpLefhIOK7KlID8Tb06vkmaaAk9Gp4cELTiQ==
X-Google-Smtp-Source: APXvYqw10/ZTwEmywFCg2NZrtTbPLslL2tQLzhjkScJOxTPClDKwvsbT+uD2Qut53hcYhTnIbsfZU6Pw6bZrRNH0wDY=
X-Received: by 2002:ac8:7585:: with SMTP id s5mr14427252qtq.38.1558014850467;
 Thu, 16 May 2019 06:54:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190516121509.1441-1-alexandru.ardelean@analog.com> <20190516133609.10975-1-alexandru.ardelean@analog.com>
In-Reply-To: <20190516133609.10975-1-alexandru.ardelean@analog.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 16 May 2019 08:53:59 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+YKsOHkXyKux_e42pAw2qDF+P-vfjxVqk4pu8v3M2vSg@mail.gmail.com>
Message-ID: <CAL_Jsq+YKsOHkXyKux_e42pAw2qDF+P-vfjxVqk4pu8v3M2vSg@mail.gmail.com>
Subject: Re: [PATCH V2] dt-bindings: iio: accel: adxl345: switch to YAML bindings
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, May 16, 2019 at 8:36 AM Alexandru Ardelean
<alexandru.ardelean@analog.com> wrote:
>
> The ADX345 supports both I2C & SPI bindings.
> This change switches from old text bindings, to YAML bindings, and also
> tries to make use of the recent multiple-examples support.
>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
> Changelog v1 -> v2:
> * dropped interrupt-parent from DT, as suggested by Rob

Please add acks/reviewed-by tags when posting new versions.

Rob
