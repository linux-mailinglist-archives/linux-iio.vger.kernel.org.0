Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7722199D55
	for <lists+linux-iio@lfdr.de>; Tue, 31 Mar 2020 19:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgCaR66 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Mar 2020 13:58:58 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44006 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbgCaR66 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Mar 2020 13:58:58 -0400
Received: by mail-io1-f67.google.com with SMTP id x9so16241652iom.10;
        Tue, 31 Mar 2020 10:58:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=td5o5/tiHIRBYofYMDETAP0Ltd0LRLXxBohco08C/no=;
        b=WhQ5BXIoFNInaHzPI7eu0BM1DVTn2dclDosGzbeE5vR+Hpjzjw8uudivAYkAJi6oT8
         o3PjdHm9DKPtVrV99xPNZ7h7pWz0TuaXOSYxlrqP2EL6C88ELRoAZ5wTWG+TQczWSRjA
         34524e58llqubX888TK0Rh1HfkPZntJe1vBkP5bh9HvQRrzDAaZv9itHl2nfb4YUhLBe
         qdt89Xe4smqHeFkl36YVanxA/mC/PjCqXr2UMmBuAssZYwtSuE3zNoRwTBKYe7hntR+p
         ArWIfWYyqJgohf0u6L0Ca2gBimDmbK33jZsvOsUFOLHrV8DGmYcZ9KUEURVVxGl/7K0g
         v2dw==
X-Gm-Message-State: ANhLgQ3Wl16e4VW6iTq3ycVh2PwDuslBnr1Py//5M8vLZWmUto6zKOT3
        VSuR/B/Ka2o0f3YnPRC6enLxzj4=
X-Google-Smtp-Source: ADFU+vusw14RdmuJ7zrBadBBFp8IzG2PeGojTVZrZsBXAA0o/Wml8YZzKjsZTDX9R92K6374xp15Yw==
X-Received: by 2002:a02:9988:: with SMTP id a8mr16525847jal.3.1585677537116;
        Tue, 31 Mar 2020 10:58:57 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id b4sm6160512ilg.58.2020.03.31.10.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 10:58:56 -0700 (PDT)
Received: (nullmailer pid 31762 invoked by uid 1000);
        Tue, 31 Mar 2020 17:58:55 -0000
Date:   Tue, 31 Mar 2020 11:58:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Daniel Campello <campello@chromium.org>
Cc:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: Add bindings for sx9310 sensor
Message-ID: <20200331175855.GA30009@bogus>
References: <20200323124310.1.I6ed779cd21abf3e70f21c1562bbda81f590976ab@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323124310.1.I6ed779cd21abf3e70f21c1562bbda81f590976ab@changeid>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Mar 23, 2020 at 12:45:14PM -0600, Daniel Campello wrote:
> Adds device tree bandings for sx9310 sensor.
> 
> Signed-off-by: Daniel Campello <campello@chromium.org>
> ---
> 
>  .../iio/proximity/semtech,sx9310.yaml         | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
> new file mode 100644
> index 00000000000000..da3424abe37e9d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license new bindings:

(GPL-2.0-only OR BSD-2-Clause)

With that,

Reviewed-by: Rob Herring <robh@kernel.org>
