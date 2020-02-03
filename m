Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D18815042E
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2020 11:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbgBCK0k (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Feb 2020 05:26:40 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33921 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgBCK0j (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Feb 2020 05:26:39 -0500
Received: by mail-pf1-f196.google.com with SMTP id i6so7356081pfc.1;
        Mon, 03 Feb 2020 02:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FmHvGOLNVPxI0kt6R17Fdw33zDx8xukTS46dymX55P0=;
        b=YAAaXbGAvy/ArWefbnDeK5nEA/0+HER/i62fidtCw7orhcmlbsCgNcbE5kcE/zAVcd
         7M24Sr93wsxNmnSj/fS+/niPdFLBopq1bN3ToJaYlWCBe71U80Oad8IR66G0JbaEVm1C
         kcyyYwltLwV5x+SGS6Aod1sO2vM1FAKmRf7fgk216sL07nKdJUxY2i0oJVAEEockrRIT
         rTWW3AEyajbWY2LLnFsMt+z++DmE/uTvy2PNPZkEAnQRLXUaK/gOPUWQErvLG/ZvcSW7
         hpoLSCa7TBLTX5IRNVTIA/3eaITSBf5RokUJmkbARQaCuRTEMARt0dodYmvVIhVSxdlt
         SmAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FmHvGOLNVPxI0kt6R17Fdw33zDx8xukTS46dymX55P0=;
        b=qnhy36StQAZmdGP+LFILSPnXqKzt3Oe+gytt2+WZARTwwiEUtHslD0g0gHW0aFvdDl
         QjCz2GYCzgGlXWBbeJW/Ns+TQ7mM1vuNj64nCcnJ1dGVEoMdTOCdlxTlgg6c0XLJi3/G
         UyIcQCMKoJ5Lcve3N56xcx4dGRm2TyCaAqVsc8Fok7PNUuUufWnQVvL1YA2E5H/+Q65T
         SyILog076MN9/fK4iKkPcevEu2rPGjxBc2xPxtC9Q5AWZZt3RRr1NuJyqywEVPeP2lfw
         wfDACl//hlf0ecIpM2Q3QR+Xa0mDHO+RX+n02GiqZNtF+8Mkd2r35InCC7nbVPrOQWAj
         KF4Q==
X-Gm-Message-State: APjAAAVCaiR40Dr0i+1mpAKR3NBhp5rvTQNptJHT93qtAWOEYw8vg4Sm
        mHrUShGjbF253Yg6o8WfUxOUbumqxgSGhltO3e4=
X-Google-Smtp-Source: APXvYqzbQt6F4/Oqw6CkftDapRy22S4nLiei4z+xGemquF8I07HdLUMWkd2f+Z1TnVGLJF2+BOjOsPDZqrGW1rVPeJw=
X-Received: by 2002:a62:1a09:: with SMTP id a9mr24181822pfa.64.1580725599101;
 Mon, 03 Feb 2020 02:26:39 -0800 (PST)
MIME-Version: 1.0
References: <20200128111302.24359-1-alexandru.ardelean@analog.com> <20200128111302.24359-3-alexandru.ardelean@analog.com>
In-Reply-To: <20200128111302.24359-3-alexandru.ardelean@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 3 Feb 2020 12:26:31 +0200
Message-ID: <CAHp75VcHU=PBzxFoLTtVMBkdB8Z0BcRQ2bq8D50YoRNPisxfcQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] MAINTAINERS: add entry for ADF4360 PLL driver
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ekigwana@gmail.com, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jan 28, 2020 at 1:13 PM Alexandru Ardelean
<alexandru.ardelean@analog.com> wrote:
>
> From: Edward Kigwana <ekigwana@gmail.com>
>
> Add entry in the MAINTAINERS file for the ADF4360 PLL driver.

> +ADF4360 PLL DRIVER
> +M:     Edward Kigwana <ekigwana@gmail.com>
> +W:     http://ez.analog.com/community/linux-device-drivers
> +L:     linux-iio@vger.kernel.org
> +S:     Maintained
> +F:     Documentation/devicetree/bindings/iio/frequency/adi,adf4360.yaml
> +F:     drivers/iio/frequency/adf4360.c

Had you run parse-maintainers.pl afterwards to see if everything is okay?

-- 
With Best Regards,
Andy Shevchenko
