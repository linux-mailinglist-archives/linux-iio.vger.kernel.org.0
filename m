Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2B016EC93
	for <lists+linux-iio@lfdr.de>; Sat, 20 Jul 2019 00:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731943AbfGSWtu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 19 Jul 2019 18:49:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:40876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727344AbfGSWtu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 19 Jul 2019 18:49:50 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A42E721874;
        Fri, 19 Jul 2019 22:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563576589;
        bh=Klt7CebjyXqGVRbXNF1U3wyGJqIWQOIIcRLJT93OQ+g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wCy7eeadZZYg4XZBwCEH/aG4rCHd2X8+WQJiqZrXJ05hWYYDpJXaZWmRfgv4FvYEM
         EuINtaeTGaWgTB9XR5asYzOpIZ7b9GSBb0mTWM1ZHC/jGKTReSTIOeTeqvrCh0vAU+
         cVlTZzQsQGSlXlgZiHR8eBtYlTA1QwdjIODnYyj0=
Received: by mail-qk1-f171.google.com with SMTP id d79so24435899qke.11;
        Fri, 19 Jul 2019 15:49:49 -0700 (PDT)
X-Gm-Message-State: APjAAAV3xo+BhMweRPDC4rqsrvLxXr4Nw7WlqDWtAPj9/6Imc3E0QQYq
        kJpn5wRCyQ57jyOfhK2pX8zCfiz1d6iHbuoBEQ==
X-Google-Smtp-Source: APXvYqzTrjLNjpoGgXzQ/tPDhplfN9MU7nWEaESSUgvy6jdg+g0UISnO9ycXnTKR/7UlNhzEJDMiPYgAxXRtGPIff+g=
X-Received: by 2002:a37:a48e:: with SMTP id n136mr37922560qke.223.1563576588892;
 Fri, 19 Jul 2019 15:49:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190717115109.15168-1-alexandru.ardelean@analog.com> <20190717115109.15168-5-alexandru.ardelean@analog.com>
In-Reply-To: <20190717115109.15168-5-alexandru.ardelean@analog.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 19 Jul 2019 16:49:37 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKZMoxdH_rpyD9kTEPtFZ=QxEV325wH=6qdhNX2nS=9ug@mail.gmail.com>
Message-ID: <CAL_JsqKZMoxdH_rpyD9kTEPtFZ=QxEV325wH=6qdhNX2nS=9ug@mail.gmail.com>
Subject: Re: [PATCH 4/4][V2] dt-bindings: iio: imu: add bindings for ADIS16460
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Jul 17, 2019 at 5:51 AM Alexandru Ardelean
<alexandru.ardelean@analog.com> wrote:
>
> This change adds device-tree bindings for the ADIS16460.
>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  .../bindings/iio/imu/adi,adis16460.yaml       | 53 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
