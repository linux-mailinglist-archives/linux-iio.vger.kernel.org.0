Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E72889F187
	for <lists+linux-iio@lfdr.de>; Tue, 27 Aug 2019 19:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730511AbfH0RZb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Aug 2019 13:25:31 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35280 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbfH0RZa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Aug 2019 13:25:30 -0400
Received: by mail-ot1-f67.google.com with SMTP id 100so8662922otn.2;
        Tue, 27 Aug 2019 10:25:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RAdx3knbJdmHJIAYuCsyCxVXwy79upfsZxSrxjBV/Fs=;
        b=IfTN3DYKpr5XEZL7/cRXpQXN6J1zwuRISho/lEYKqz54sNvHcY34eqcH2sBNC7oI5N
         yY7JIJKMTqH0jkkXmwqMh/7tdq1javjDkRkCfEX4Beyh34xoJ1TATFVf6+KKVdcQo/os
         DTvm6E+4keBWl2HE5FX/X3j8r5NcGt8GF4zVbfZy9OAchYypqmancdhTggDeabuAqYJK
         W4O7lJVWryBvezGyAWPOytI7Sq2+Tm581hxoa6K6zllGgrimCBGu8m1bYq6vqEONeAJa
         PCc8V5zPWzIubfS1J4Z/CCg+Q7U3fqL12jLUWwS7/nA41XrVrXOnwsxVoN3AXQB9HCPH
         hD7g==
X-Gm-Message-State: APjAAAUMJg1vuCCOvQb7ZJHPbR3d1VMBb46moxl+5Go0DEdmF+zBesn0
        inhss+DCLSMKrrXtdSn4YQ==
X-Google-Smtp-Source: APXvYqzyYML6e8inoQ40na2bt0XfhvJ9YzCYogrNaMHwGOZqEiHXi8Yf1Csw2h9ooroMQd1yb4hqUA==
X-Received: by 2002:a9d:3bcb:: with SMTP id k69mr8186736otc.182.1566926730130;
        Tue, 27 Aug 2019 10:25:30 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z16sm4238710oic.10.2019.08.27.10.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 10:25:29 -0700 (PDT)
Date:   Tue, 27 Aug 2019 12:25:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     lorenzo.bianconi83@gmail.com, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: Re: [PATCH v5 4/4] dt-bindings: iio: imu: st_lsm6dsx: add lsm9ds1
 device bindings
Message-ID: <20190827172529.GA16508@bogus>
References: <20190821132520.28225-1-martin.kepplinger@puri.sm>
 <20190821132520.28225-5-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821132520.28225-5-martin.kepplinger@puri.sm>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 21 Aug 2019 15:25:20 +0200, Martin Kepplinger wrote:
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
>  Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
