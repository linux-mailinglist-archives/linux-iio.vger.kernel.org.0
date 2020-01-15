Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC40113B65E
	for <lists+linux-iio@lfdr.de>; Wed, 15 Jan 2020 01:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbgAOAIj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Jan 2020 19:08:39 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43722 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgAOAIj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Jan 2020 19:08:39 -0500
Received: by mail-oi1-f196.google.com with SMTP id p125so13694017oif.10
        for <linux-iio@vger.kernel.org>; Tue, 14 Jan 2020 16:08:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0caRa5XG3dj99WMQy0XFQRo3RUPxiFm3CleZQAkYe78=;
        b=hoxRVa+aC6j9lgTuS51tI6NFuE+172cTnq2VkjS4Cx/68mkDulecK2CDhdn++H0hGD
         aJ7Jl9u4mprU+xUK1mFwkf7l5FoOr5gjzvyj2hZkK8zw6uTSvMHelOG4/6rN+eVasTQ5
         m+YDbIg/Hxvqgx5Akn8iQNAXxKs96pi07BeNS6APChicVNeuQ0Q7hWtd/phM7gpGwXjp
         OlQnBUngc6HY7mW6Vlhz91bBfPDLnabolneZMkZRYGnopO1zAgLfDgmamC4NimboRNXx
         ZPK4cDH9oPDsCqb2aT/v8yCFuEJccoW9heuHpRhq1Hft3RxWV6UW0m+K8ZMdGe+IqvpN
         +bXA==
X-Gm-Message-State: APjAAAUm6VUBu0TyOD3GIQo2nb3jANYOc1M/apMA+FhYlSo1MeFFvVjI
        PQ1ybXVzyskdLADfTh/wfi7xXGQ=
X-Google-Smtp-Source: APXvYqyBNCiXCPU48SFpmw/J10Uh23veTHq5cuVGrFFYYArliKVMh7CD7pGdzSt7W1WmfIQJ3G8w3w==
X-Received: by 2002:a05:6808:64d:: with SMTP id z13mr19200159oih.104.1579046918823;
        Tue, 14 Jan 2020 16:08:38 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f3sm5924124otl.38.2020.01.14.16.08.37
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 16:08:38 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2209ae
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Tue, 14 Jan 2020 18:08:37 -0600
Date:   Tue, 14 Jan 2020 18:08:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        rpi-receiver@htl-steyr.ac.at, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: devantech-srf04.yaml: add pm feature
Message-ID: <20200115000837.GA11941@bogus>
References: <20200109083814.GA5368@arbad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109083814.GA5368@arbad>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 9 Jan 2020 09:38:16 +0100, Andreas Klinger wrote:
> Add GPIO line and startup time for usage of power management
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> ---
>  .../iio/proximity/devantech-srf04.yaml         | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
