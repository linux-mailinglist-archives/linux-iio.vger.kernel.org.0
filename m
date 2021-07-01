Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0344E3B9691
	for <lists+linux-iio@lfdr.de>; Thu,  1 Jul 2021 21:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhGATck (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Jul 2021 15:32:40 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:41765 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhGATck (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Jul 2021 15:32:40 -0400
Received: by mail-io1-f54.google.com with SMTP id i189so8919632ioa.8;
        Thu, 01 Jul 2021 12:30:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BCG+l1C0nlzP57WAnie7tTGSrBQ2K9z9qcnBqa3mQ08=;
        b=obIteTTg35u9d1tXJFmpd0bNRSmSnyu16aLyyoXsbtmPDB9S7pUXL1BEwaJgFngy2F
         kfLyLy0jV/iEt+a8JtFN4d4MsgWh373A+iZFrVVgIlsR/peaGkd3uoFqOuBw3jyS51h8
         fANDi5gNupaCQ0Yw2EoehAL7Klv5wTB9odQwEjPUAMgQMKj11f8qZHAB2D2Em1xA8WMe
         nHV5Reg9RgfMjd76I7+h2CK0Bi/DGljZmeCqZUxhAnLIhpIhRCvtRoo1LKYlnjreSrqV
         RUUJ2NejDf1FTIM//713FRF1kKPbxjJg6X3xcaNgQrCKIQT2z5C5qPtJedMmy7dlsEAk
         mLnw==
X-Gm-Message-State: AOAM533B/UeuCg0a9Z2e2/A2YWtZ/WPTj8nItKVBuQPrGcJKG0bU/yv6
        WtjWrG3GJ8thyUJHlQu7x1D6ASSsUQ==
X-Google-Smtp-Source: ABdhPJz4zXBaD9zMJvFJEHcOBwmEkGRfn6ddfTYtBYMSOQaXcjX/t5kYLbUv78gkyUNkSccdacxizw==
X-Received: by 2002:a6b:b5c7:: with SMTP id e190mr789909iof.31.1625167808431;
        Thu, 01 Jul 2021 12:30:08 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id q131sm337757iod.54.2021.07.01.12.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 12:30:07 -0700 (PDT)
Received: (nullmailer pid 2783045 invoked by uid 1000);
        Thu, 01 Jul 2021 19:30:05 -0000
Date:   Thu, 1 Jul 2021 13:30:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 05/15] dt-bindings: iio: dac: ad5446: Add missing binding
 document
Message-ID: <20210701193005.GA2780955@robh.at.kernel.org>
References: <20210627163244.1090296-1-jic23@kernel.org>
 <20210627163244.1090296-6-jic23@kernel.org>
 <1625148163.528787.2278697.nullmailer@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1625148163.528787.2278697.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jul 01, 2021 at 08:02:43AM -0600, Rob Herring wrote:
> On Sun, 27 Jun 2021 17:32:34 +0100, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Binding is a little stricter than the Linux driver.
> > 
> > It requires vcc-supply to be present for devices that don't have
> > an internal reference, whereas the driver just prints a message and
> > carries on.  Given this means that it is impossible to establish
> > a scaling of the output channel, let us make it required in the binding
> > schema.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Lars-Peter Clausen <lars@metafoo.de>
> > ---
> >  .../bindings/iio/dac/adi,ad5446.yaml          | 105 ++++++++++++++++++
> >  1 file changed, 105 insertions(+)
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/dac/ti,dac7512.example.dt.yaml: dac@0: 'vcc-supply' is a required property
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/dac/adi,ad5446.yaml

Humm, seems it's not missing?

Rob
