Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74900D655B
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2019 16:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732589AbfJNOjw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 14 Oct 2019 10:39:52 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35667 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731121AbfJNOjw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 14 Oct 2019 10:39:52 -0400
Received: by mail-oi1-f196.google.com with SMTP id x3so13951870oig.2;
        Mon, 14 Oct 2019 07:39:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=eo4xJ1OXygldw/b7h5q54GYC5T4vYPchQbPjBZYkD3U=;
        b=ED+DIYbvkicDLjuCThtLhXHbl/TkiznCLUDzGpyM7DkJB1CfP+MBZDYh2ucN0fzsEC
         aUtcUbrzAfOK++zJ7xXoCGCBWXYKWhdDU/LdcRZW7cjQtPWYKJlFCFsI3qWtLq4UN4ia
         pL6f9C57nLPK3T8VZWeYJ9UCBb8/CRPf3PbxTH+8qG4eIrNCJHoxHWdOnmpQy+9CleMa
         XxOhqhzTjstkz3w8z9oHSj3rNRIgyOLQ2zG5pentoXDhTFRf3jFHDUBgefshiD5MBnYN
         KkZGwGodHn6jotJT8lM/Kaw577uO6sq55tjFCX5ctJhIl6VMDZjKxX252uMi9G6tr87C
         BbmQ==
X-Gm-Message-State: APjAAAXdmJko339d6Tr6mC32qLEziOBfAgshq0p/wGqFRsxCm9G5bTD1
        CS5UC8pkaeTvXf9yJs/CEw==
X-Google-Smtp-Source: APXvYqzexNNFFs++uozL9Up2JJe/dEon0du1IjSVKTZQfCDEuAdvy2/L8PVrM/RmQQKTQ9HZM0Ds+Q==
X-Received: by 2002:aca:2b08:: with SMTP id i8mr23478642oik.146.1571063991584;
        Mon, 14 Oct 2019 07:39:51 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b4sm5192094oiy.30.2019.10.14.07.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2019 07:39:51 -0700 (PDT)
Date:   Mon, 14 Oct 2019 09:39:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        mark.rutland@arm.com
Subject: Re: [PATCH v4 2/2] dt-bindings: iio: Add ltc2983 documentation
Message-ID: <20191014143950.GA6163@bogus>
References: <20191011084038.45829-1-nuno.sa@analog.com>
 <20191011084038.45829-2-nuno.sa@analog.com>
 <20191012115745.069119b0@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191012115745.069119b0@archlinux>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Oct 12, 2019 at 11:57:45AM +0100, Jonathan Cameron wrote:
> On Fri, 11 Oct 2019 10:40:38 +0200
> Nuno Sá <nuno.sa@analog.com> wrote:
> 
> > Document the LTC2983 temperature sensor devicetree bindings.
> > 
> > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> 
> I'm happy with this, but will be waiting for Rob to have a chance
> for a final look before applying.

LGTM, but I need to add the int64-matrix type to the core schema first 
or this will give you errors. I should get to that in the next day or 
so.

Rob
