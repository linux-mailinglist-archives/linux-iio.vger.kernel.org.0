Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 385FFE0662
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2019 16:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730121AbfJVO1o (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Oct 2019 10:27:44 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35177 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727323AbfJVO1n (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Oct 2019 10:27:43 -0400
Received: by mail-qk1-f193.google.com with SMTP id w2so16411980qkf.2;
        Tue, 22 Oct 2019 07:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X0ZOGYsSTOrqAuUJQSbLUK9pxP5SaCYK2GX9ZXRXpGo=;
        b=buFDSpnktDPCZOnBms8qhalNZimgAYSLbVNQ08D23fWAEr8Amk28tWNY7kQrcLSKYX
         LLNIQU13CSzasXYCEmisROuDbWG4K9DilKBU7R7n8luUguLxMsy04Ky6L2KPh/n8PDHT
         ylk1MLCdbtCnrHbu8wwBUOJUrnENaxHvyOcfhP01bl4SkovkcesoK98SGOvZOZdDEtK5
         sS4rtifd2yyyLy3aVYojExK/aaQDXD0CW7r0hdfYwnkSNQNVYaICjioD9pihR7Al5zeM
         E3IjnFA0NV2BspGqs/LX5ub01djtBsefxTQkc8G6SiGf8dQZj+qaRYq0Er3icg7c9Acs
         35Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X0ZOGYsSTOrqAuUJQSbLUK9pxP5SaCYK2GX9ZXRXpGo=;
        b=IgqPSbOeJ6PJQwJKoOJCTD6OWuzb9KdlURXdEjYK0tgJ1EeFeTX9Dubf7Ke4rmp3UR
         KkdvYV/HNvsRx6WTPD3nRLdolCwV0njq1EiRXMB2eduET8zf0fBxg6KwsKctxhkt1xJL
         leEwqn8UgVQ/PKBl+pD28lYa8rLllccoEA/a3tqbsGRU6O4NdXdXdnCozEbtrReMr/jo
         dBZz5wLIi8070WrHnEnd06Pp77lJaed39JW0/IV2sfOQ7Hd9vtM6fdqNgGfTEvo6B87N
         Rb/tIqOkGbQZeJzAa38jjhTIHsPfv2WBvWk6Zm62YIU4CcqxDUoV3tzGb9wRZFhhFm24
         SNaA==
X-Gm-Message-State: APjAAAW9x74UX1HAnwRnuMgolDSD4cKq+xSV6TWitsz4oSo7DxD2V6Re
        vcdwRF2HlZ004sWfabEW+n7CoJL4V/k=
X-Google-Smtp-Source: APXvYqxNL03HGLClVr1AH7C8sRxH8TcjK0Dkh8gIZmURmo0hIogq04ewNWkBtNqsKIOZASOCvveTbw==
X-Received: by 2002:a37:9202:: with SMTP id u2mr3291112qkd.8.1571754462621;
        Tue, 22 Oct 2019 07:27:42 -0700 (PDT)
Received: from smtp.gmail.com (gwcrusp.semfio.usp.br. [143.107.150.86])
        by smtp.gmail.com with ESMTPSA id k29sm9824775qtu.70.2019.10.22.07.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 07:27:41 -0700 (PDT)
Date:   Tue, 22 Oct 2019 11:27:37 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     dragos.bogdan@analog.com, alexandru.ardelean@analog.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        kernel-usp@googlegroups.com
Subject: Re: [PATCH v2 1/2] iio: adc: Add driver support for AD7292
Message-ID: <20191022142736.ztch3mzqpv6jcvhm@smtp.gmail.com>
References: <20191016025119.53fclzngzt5qwlmk@smtp.gmail.com>
 <20191021180644.3a260af2@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021180644.3a260af2@archlinux>
User-Agent: NeoMutt/20180716
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

Should I send a V3 for the whole patchset or just for the DT binding patch?

Thanks,

Marcelo

On 10/21, Jonathan Cameron wrote:
> On Tue, 15 Oct 2019 23:51:22 -0300
> Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:
> 
> > The AD7292 is a 10-bit monitor and control system with ADC, DACs,
> > temperature sensor, and GPIOs.
> > 
> > Configure AD7292 devices in direct access mode, enabling single-ended
> > ADC readings.
> > 
> > Datasheet:
> > Link: https://www.analog.com/media/en/technical-documentation/data-sheets/ad7292.pdf
> > 
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> This looks fine to me.
> 
> Assuming nothing else comes up, I'll pick this up once the binding was tidied up.
> 
> Thanks,
> 
> Jonathan
> 
