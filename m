Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11BB35C385
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jul 2019 21:14:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfGATOE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 1 Jul 2019 15:14:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:56972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726509AbfGATOE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 1 Jul 2019 15:14:04 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8329E2183F;
        Mon,  1 Jul 2019 19:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562008443;
        bh=Npf2ZLK+YvbRuR9twpc+krnhiPOW2wMFwVIdnqN5JqQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=flFiVqGCvfcXPuIeAdBYQ645aaDv1KcSRcDYxgnBYJf84XizqlGOY23OyCUV/Dvsl
         qWmiBQgFSd55MAIdjT9gafJfjpe+fZpr6hEHkKR3SoZ9dZCPvIQpB9LPe7zq/wuD62
         SAVnNPwkQ0MjsRE5cV0IWmL8tjlHUvvhLDmj2sv8=
Received: by mail-qk1-f169.google.com with SMTP id c70so11938010qkg.7;
        Mon, 01 Jul 2019 12:14:03 -0700 (PDT)
X-Gm-Message-State: APjAAAUPdfWD73xyI3ZZzgQ1xI87voKYihrTiCFYOgOcvIEgV/LxmRng
        6mMU2lBOI5MoJ8sd3qlS8bwqFQZ7GW4Rm3qs8A==
X-Google-Smtp-Source: APXvYqw94pWnQhyAKVMPyGJC0DCMp9FcnT2dJ+7x7e7D7x+ONjb+1RwRrIevTD05Fg2Zf9JHoMU/KgitDn7+vFJdxXw=
X-Received: by 2002:ae9:ebd1:: with SMTP id b200mr22436844qkg.152.1562008442787;
 Mon, 01 Jul 2019 12:14:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190628175713.14831-1-martyn.welch@collabora.com>
In-Reply-To: <20190628175713.14831-1-martyn.welch@collabora.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 1 Jul 2019 13:13:51 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ6Kmmw1WisFswq6s71ZyoEFC8P-SasrwKngbEw2OH5YA@mail.gmail.com>
Message-ID: <CAL_JsqJ6Kmmw1WisFswq6s71ZyoEFC8P-SasrwKngbEw2OH5YA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: Add binding document for NOA1305
To:     Martyn Welch <martyn.welch@collabora.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel@lists.collabora.co.uk, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jun 28, 2019 at 11:57 AM Martyn Welch
<martyn.welch@collabora.com> wrote:
>
> Document the ON Semiconductor NOA1305 ambient light sensor devicetree
> bindings.
>
> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
> ---
>
> Changes:
> v2: Same as v1.
>
>  .../bindings/iio/light/noa1305.yaml           | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/noa1305.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
